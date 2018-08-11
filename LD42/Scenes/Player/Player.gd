extends KinematicBody2D

var speed = 300
var movedir = Vector2()
onready var screensize = get_viewport_rect().size
var time = 0
var timetext
var health = 5
var invincible = false

func _ready():
	time = 35
	timetext = "35"
	health = 5
	invincible = false

func _physics_process(delta):
	movedir = move_and_slide(movedir)
	movedir.y = 725
	$GUI/Control/Timeleft.text = timetext
	
	var target_speed = 0
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		target_speed += 1
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		target_speed += -1
	
	movedir.x = target_speed * speed
	position.x = clamp(position.x, 0, screensize.x)
	
	if health == 0:
		movedir.y = 0
		$Sprite.hide()
		$Particles2D.emitting = false
		$GUI/Control/YouDied.show()
		$CountDown.stop()

func _on_CountDown_timeout():
	if time > 0:
		$CountDown.start()
		$Tick.play()
		time -= 1
		timetext = str(time)

func damage():
	if invincible == false:
		health -= 1
		invincible = true
		$Invinc.start()
		$Hurt.play()

func _on_Invinc_timeout():
	invincible = false

func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
