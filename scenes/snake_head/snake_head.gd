extends CharacterBody2D

var snake_speed = 100
var score = 0
var size = 3
var curr_dir = Vector2(1, 0)
var part_size = 25
@export var body: PackedScene


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_dir = get_dir()
	if new_dir != Vector2.ZERO and abs(new_dir) != Vector2.ONE:
		curr_dir = new_dir
	velocity = curr_dir * snake_speed
	var temp_old_pos = global_position
	move_and_slide()
	rotation = curr_dir.angle()


func get_dir():
	var x_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_dir = -Input.get_action_strength("move_up") + Input.get_action_strength("move_down")
	return Vector2(x_dir, y_dir)


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("apple"):
		score += 1
		snake_speed += 10
		# var apple_sizex = area.get_parent().global_transform.x
		# var apple_sizey = area.get_parent().get_node("Sprite2D").global_transform.y
		var x_pos = randf_range(0, get_viewport().size.x)
		var y_pos = randf_range(0, get_viewport().size.y)
		area.get_parent().global_position = Vector2(x_pos, y_pos)
