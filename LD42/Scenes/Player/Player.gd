extends KinematicBody2D

var speed = 300
var movedir = Vector2()
var health = 3
var screensize

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(delta):
	movedir = move_and_slide(movedir)
	
	var target_speed = 0
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		target_speed += 1
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		target_speed += -1
	
	movedir.x = target_speed * speed
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
