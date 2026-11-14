extends RefCounted
## Logical territory data, independent of the 3D presentation.

const COLUMNS := 4
const ROWS := 3
const CELL_SIZE := 10.0

static func create_provinces() -> Array[Dictionary]:
	var provinces: Array[Dictionary] = []
	for row in range(ROWS):
		for column in range(COLUMNS):
			provinces.append({
				"id": row * COLUMNS + column + 1,
				"name": "Province %02d" % (row * COLUMNS + column + 1),
				"column": column,
				"row": row,
			})
	return provinces

static func province_at(point: Vector3) -> int:
	var column := floori((point.x + COLUMNS * CELL_SIZE / 2.0) / CELL_SIZE)
	var row := floori((point.z + ROWS * CELL_SIZE / 2.0) / CELL_SIZE)
	if column < 0 or column >= COLUMNS or row < 0 or row >= ROWS:
		return -1
	return row * COLUMNS + column

