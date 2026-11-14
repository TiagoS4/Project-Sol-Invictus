extends Node3D

const MapData = preload("res://scripts/map_data.gd")
const MapCamera = preload("res://scripts/map_camera.gd")
const PALETTE: Array[Color] = [
	Color("#827f54"), Color("#96905e"), Color("#a3996a"), Color("#88895f"),
	Color("#ac9764"), Color("#8c9469"), Color("#9c865a"), Color("#b0a277"),
	Color("#90966b"), Color("#a89b70"), Color("#7e8963"), Color("#b0a582"),
]

var provinces: Array[Dictionary] = MapData.create_provinces()
var tiles: Array[MeshInstance3D] = []
var camera: Camera3D
var selection_label: Label
var selected_index := -1

func _ready() -> void:
	_create_environment()
	_create_map()
	camera = MapCamera.new()
	add_child(camera)
	_create_interface()

func _create_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#18272d")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#e4e1cb")
	environment.ambient_light_energy = 0.7
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-60.0, -25.0, 0.0)
	sun.light_color = Color("#fff1d6")
	sun.light_energy = 1.1
	add_child(sun)

func _create_map() -> void:
	for index in range(provinces.size()):
		var province: Dictionary = provinces[index]
		var tile := MeshInstance3D.new()
		tile.name = "Province%02d" % province["id"]
		var box := BoxMesh.new()
		# A small visual inset exposes the borders; logical cells remain contiguous.
		box.size = Vector3(MapData.CELL_SIZE - 0.12, 0.6, MapData.CELL_SIZE - 0.12)
		tile.mesh = box
		tile.position = Vector3(
			(float(province["column"]) - (MapData.COLUMNS - 1) / 2.0) * MapData.CELL_SIZE,
			-0.3,
			(float(province["row"]) - (MapData.ROWS - 1) / 2.0) * MapData.CELL_SIZE
		)
		var material := StandardMaterial3D.new()
		material.albedo_color = PALETTE[index]
		material.roughness = 1.0
		tile.material_override = material
		add_child(tile)
		tiles.append(tile)
		var label := Label3D.new()
		label.text = "%02d" % province["id"]
		label.font_size = 64
		label.pixel_size = 0.025
		label.modulate = Color("#fff2cc")
		label.outline_modulate = Color("#34382c")
		label.outline_size = 10
		label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		label.position = tile.position + Vector3(0.0, 0.9, 0.0)
		add_child(label)

func _create_interface() -> void:
	var canvas := CanvasLayer.new()
	add_child(canvas)
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 28)
	margin.add_theme_constant_override("margin_top", 24)
	margin.add_theme_constant_override("margin_right", 28)
	margin.add_theme_constant_override("margin_bottom", 24)
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(margin)
	var column := VBoxContainer.new()
	column.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.add_child(column)
	var title := Label.new()
	title.text = "SOL INVICTUS"
	title.add_theme_font_size_override("font_size", 30)
	column.add_child(title)
	var subtitle := Label.new()
	subtitle.text = "FOUNDATION MAP  /  12 PROVINCES  /  4 × 3"
	subtitle.add_theme_color_override("font_color", Color("#c5be9c"))
	column.add_child(subtitle)
	var spacer := Control.new()
	spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	column.add_child(spacer)
	selection_label = Label.new()
	selection_label.text = "Select a province to inspect it."
	selection_label.add_theme_font_size_override("font_size", 22)
	column.add_child(selection_label)
	var help := Label.new()
	help.text = "Click: select   •   WASD / arrows: move   •   Wheel: zoom   •   Home: reset   •   Esc: deselect"
	column.add_child(help)
	for child in column.get_children():
		if child is Control:
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		select_at_screen(event.position)
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		select_province(-1)

func select_at_screen(screen_position: Vector2) -> void:
	var origin := camera.project_ray_origin(screen_position)
	var direction := camera.project_ray_normal(screen_position)
	var intersection: Variant = Plane(Vector3.UP, 0.0).intersects_ray(origin, direction)
	if intersection == null:
		select_province(-1)
		return
	select_province(MapData.province_at(intersection))

func select_province(index: int) -> void:
	if index < -1 or index >= provinces.size():
		return
	if selected_index >= 0:
		var old_material := tiles[selected_index].material_override as StandardMaterial3D
		old_material.albedo_color = PALETTE[selected_index]
	selected_index = index
	if index == -1:
		selection_label.text = "Select a province to inspect it."
		return
	var material := tiles[index].material_override as StandardMaterial3D
	material.albedo_color = Color("#dfbf69")
	var province: Dictionary = provinces[index]
	selection_label.text = "%s  |  Row %d · Column %d" % [
		province["name"], province["row"] + 1, province["column"] + 1
	]

