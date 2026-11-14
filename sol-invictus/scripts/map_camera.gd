extends Camera3D

const DEFAULT_SIZE := 54.0
var focus := Vector3.ZERO

func _ready() -> void:
	projection = Camera3D.PROJECTION_ORTHOGONAL
	size = DEFAULT_SIZE
	current = true
	_update_pose()

func _process(delta: float) -> void:
	var direction := Vector3(
		float(Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT))
		- float(Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT)),
		0.0,
		float(Input.is_physical_key_pressed(KEY_S) or Input.is_physical_key_pressed(KEY_DOWN))
		- float(Input.is_physical_key_pressed(KEY_W) or Input.is_physical_key_pressed(KEY_UP))
	)
	if direction != Vector3.ZERO:
		focus += direction.normalized() * size * 0.6 * delta
		focus.x = clampf(focus.x, -25.0, 25.0)
		focus.z = clampf(focus.z, -20.0, 20.0)
		_update_pose()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			size = clampf(size * 0.9, 20.0, 80.0)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			size = clampf(size / 0.9, 20.0, 80.0)
	if event is InputEventKey and event.pressed and event.keycode == KEY_HOME:
		focus = Vector3.ZERO
		size = DEFAULT_SIZE
		_update_pose()

func _update_pose() -> void:
	position = focus + Vector3(0.0, 50.0, 36.0)
	look_at(focus, Vector3.UP)

