@tool
extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	#self.get_pattern(0, [Vector2i(0,0)])
	var maze = generate_maze(8, 8)
	render_maze(maze)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Directions are defined as a dictionary for easy lookup.
var DX = {'NORTH': 0, 'SOUTH': 0, 'EAST': 1, 'WEST': -1}
var DY = {'NORTH': -1, 'SOUTH': 1, 'EAST': 0, 'WEST': 0}
var OPPOSITE = {'NORTH': 'SOUTH', 'SOUTH': 'NORTH', 'EAST': 'WEST', 'WEST': 'EAST'}


func generate_maze(width, height):
	# Create a grid with all walls intact
	var maze = create_grid(width, height)
	
	# Start the recursive algorithm at point (0, 0)
	carve_passages_from(0, 0, maze)
	
	return maze

func create_grid(width, height):
	var grid = []
	for i in range(height):
		var row = []
		for j in range(width):
			# Initialize each cell with all walls present
			row.append({'NORTH': true, 'SOUTH': true, 'WEST': true, 'EAST': true, 'visited': false})
		grid.append(row)
	return grid
	
func carve_passages_from(cx, cy, grid):
	# Mark the current cell as visited
	grid[cy][cx]['visited'] = true
	
	# Randomly order directions to move (NORTH, SOUTH, EAST, WEST)
	var directions = ['NORTH', 'SOUTH', 'EAST', 'WEST']
	directions.shuffle()  # Shuffle the array to ensure random order
	
	for direction in directions:
		# Calculate the new cell's position
		var nx = cx + DX[direction]
		var ny = cy + DY[direction]

		# Check if the new cell position is within the grid boundaries and if it has not been visited
		if 0 <= nx and nx < grid[0].size() and 0 <= ny and ny < grid.size() and not grid[ny][nx]['visited']:
			# Remove the walls between the current cell and the chosen cell
			grid[cy][cx][direction] = false
			grid[ny][nx][OPPOSITE[direction]] = false
			
			# Recursively call this function for the next cell
			carve_passages_from(nx, ny, grid)
			
func render_maze(grid):
	for y in range(grid.size()):
		
		for x in range(grid[y].size()):
			var cell = grid[y][x]

			var tileId = 0

			if cell['NORTH']:
				tileId |= 1 << 0 

			if cell['SOUTH']:
				tileId |= 1 << 2

			if cell['WEST']:
				tileId |= 1 << 3

			if cell['EAST']:
				tileId |= 1 << 1
				

			var tileSetPattern = tile_set.get_pattern(tileId)
			set_pattern(0, Vector2i(x * 16, y * 16), tileSetPattern)
		


