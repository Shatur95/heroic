extends "res://Scripts/Creatures/Humanoid.gd"

func _ready():
	if is_network_master():
		$Camera.make_current()

func _process(delta):
	if can_move:
		if (is_network_master()):
			velocity = Vector2()
			
			# Change the player's vector depending on the keys
			if Input.is_action_pressed("ui_up"):
				velocity.y -= 1
			if Input.is_action_pressed("ui_left"):
			 	velocity.x -= 1
			if Input.is_action_pressed("ui_down"):
			 	velocity.y += 1
			if Input.is_action_pressed("ui_right"):
				velocity.x += 1
		
			# Normalize vector
			if velocity.length() > 0:
	        	velocity = velocity.normalized() * speed
			
			rset("velocity", velocity)
		
		move_and_collide(velocity * delta)
		if (is_network_master()):
			rpc("_set_position", position)
		
		# Animate movement
		if velocity.x == 0 and velocity.y < 0:
			if $Body/Animation.current_animation != "up":
				direction = UP
				$Body/Animation.play("up")
				$Hair/Animation.play("up")
				$Eyes/Animation.play("up")
		elif velocity.x < 0:
			if $Body/Animation.current_animation != "left":
				direction = LEFT
				$Body/Animation.play("left")
				$Hair/Animation.play("left")
				$Eyes/Animation.play("left")
		elif velocity.x == 0 and velocity.y > 0:
			if $Body/Animation.current_animation != "down":
				direction = DOWN
				$Body/Animation.play("down")
				$Hair/Animation.play("down")
				$Eyes/Animation.play("down")
		elif velocity.x > 0:
			if $Body/Animation.current_animation != "right":
				direction = RIGHT
				$Body/Animation.play("right")
				$Hair/Animation.play("right")
				$Eyes/Animation.play("right")
		else:
			match direction:
				UP:
					$Body.set_frame(104)
					$Hair.set_frame(104)
					$Eyes.set_frame(104)
				LEFT:
					$Body.set_frame(117)
					$Hair.set_frame(117)
					$Eyes.set_frame(117)
				DOWN:
					$Body.set_frame(130)
					$Hair.set_frame(130)
					$Eyes.set_frame(130)
				RIGHT:
					$Body.set_frame(143)
					$Hair.set_frame(143)
					$Eyes.set_frame(143)

remote func _set_position(newPosition):
	position = newPosition