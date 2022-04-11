extends KinematicBody2D

const UP = Vector2.UP
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 150
const JUMPFORCE = 300
const ACC = 10

var velocity = Vector2.ZERO

var facing_right = true


 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	#controle gravity
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
	print(velocity)
	
	if Input.is_action_just_pressed("hit"):
		$AnimationPlayer.play("actionHit",1,2.25)
	#controle player direction
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	velocity.x = clamp(velocity.x, -MAXSPEED, MAXSPEED)
	if Input.is_action_pressed("right"):
		velocity.x += ACC
		facing_right = true
		$AnimationPlayer.play("Running")
		
	elif Input.is_action_pressed("left"):
		velocity.x += -ACC
		facing_right = false
		$AnimationPlayer.play("Running")
	else:
		velocity.x = lerp(velocity.x,0,0.2)
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = -JUMPFORCE

	if !is_on_floor():
		if velocity.y<0:
			$AnimationPlayer.play("Jumping")
		elif velocity.y>0:
			$AnimationPlayer.play("falling")
			
			
		
	velocity = move_and_slide(velocity,UP)
	
#Other methode
func getInput():
	velocity.y +=GRAVITY
	if velocity.y > GRAVITY:
		velocity.y = MAXFALLSPEED
	
	velocity.x = 0
	$AnimationPlayer.play("Idle")
	
	if Input.is_action_just_pressed("right"):
		velocity.x = MAXSPEED
		$AnimationPlayer.play("Running")
		$Sprite.scale.x = 1
		
	if Input.is_action_just_pressed("left"):
		velocity.x = -MAXSPEED
		$AnimationPlayer.play("Running")
		$Sprite.scale.x = -1
	
	if Input.is_action_just_pressed("hit"):
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("actionHit")
		
	
	
	
	
	
	
	
	
	
	




#	if is_on_floor():
#		doubleJump = 0
#	if Input.is_action_just_pressed("jump") && doubleJump<2:
#		velocity.y = -JUMPFORCE 
#		doubleJump = doubleJump+1
#
#	print(doubleJump)
	
