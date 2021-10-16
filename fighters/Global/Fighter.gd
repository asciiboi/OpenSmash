extends KinematicBody2D


var canMove = true
var Die = false
var gravity = 500.0
export var WalkSpeed = 200

export (NodePath) var OffscreenEffectPath
export (NodePath) var DeathTimerPath

var OffscreenEffect
var DeathTimer
var velocity = Vector2()

func _ready():
	OffscreenEffect = get_node(OffscreenEffectPath)
	DeathTimer = get_node(DeathTimerPath)

func _physics_process(delta):
	if canMove:
		if not is_on_floor():
			velocity.y += delta * gravity
		else: velocity.y = 0

		if Input.is_action_pressed("ui_left"):
			velocity.x = -WalkSpeed
		elif Input.is_action_pressed("ui_right"):
			velocity.x =  WalkSpeed
		else:
			velocity.x = 0
		
		move_and_slide(velocity, Vector2(0, -1))


func on_Offscreen():
	OffscreenEffect.look_at(Globals.StageCenter)
	OffscreenEffect.emitting = true
	canMove = false
	DeathTimer.start()


func _on_Death_timeout():
	queue_free()
