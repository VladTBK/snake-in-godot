extends Node2D

var snake_speed = 1
var score = 0
var curr_dir = Vector2(1, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_dir = get_dir()
	if new_dir != Vector2.ZERO and abs(new_dir) != Vector2.ONE:
		curr_dir = new_dir

	global_position += snake_speed * curr_dir
	rotation = curr_dir.angle()


func get_dir():
	var x_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_dir = -Input.get_action_strength("move_up") + Input.get_action_strength("move_down")
	return Vector2(x_dir, y_dir)


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("apple"):
		area.get_parent().queue_free()
		score += 1
		snake_speed += 0.5
