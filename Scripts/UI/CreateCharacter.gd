extends Control

func _process(delta: float) -> void:
	# Change the player's vector depending on the keys
	if Input.is_action_pressed("ui_up") and $Character/Body/Animation.current_animation != "up":
		$Character/Body/Animation.play("WalkUp")
		$Character/Hair/Animation.play("WalkUp")
		$Character/Eyes/Animation.play("WalkUp")
	if Input.is_action_pressed("ui_left") and $Character/Body/Animation.current_animation != "left":
		$Character/Body/Animation.play("WalkLeft")
		$Character/Hair/Animation.play("WalkLeft")
		$Character/Eyes/Animation.play("WalkLeft")
	if Input.is_action_pressed("ui_down") and $Character/Body/Animation.current_animation != "down":
		$Character/Body/Animation.play("WalkDown")
		$Character/Hair/Animation.play("WalkDown")
		$Character/Eyes/Animation.play("WalkDown")
	if Input.is_action_pressed("ui_right") and $Character/Body/Animation.current_animation != "right":
		$Character/Body/Animation.play("WalkRight")
		$Character/Hair/Animation.play("WalkRight")
		$Character/Eyes/Animation.play("WalkRight")

func _ready() -> void:
	$Character/Body/Animation.play("WalkDown")
	$Character/Hair/Animation.play("WalkDown")
	$Character/Eyes/Animation.play("WalkDown")
	$Character/HealthBar.visible = false
	$Panel/Controls/Hair/ColorPicker.color = Color(randf(), randf(), randf())

func _set_sex(id: int) -> void:
	# Disable some hairs for male (id = 0)
	for i in range(17, 30):
		$Panel/Controls/Hair/Type.set_item_disabled(i, !id)
	
	# Check if character has wrong hair
	if id == 0 and $Panel/Controls/Hair/Type.selected >= 17:
		$Panel/Controls/Hair/Type.selected = 16
		$Character.hair = $Panel/Controls/Hair/Type.get_item_text(16)
	
	$Character.sex = $Panel/Controls/Sex/Type.get_item_text(id)
	$Character.load_sprite()

func _set_race(id: int) -> void:
	$Character.race = $Panel/Controls/Race/Type.get_item_text(id)
	$Character.load_sprite()

func _set_hair(id: int) -> void:
	$Character.hair = $Panel/Controls/Hair/Type.get_item_text(id)
	$Character.load_sprite()
	$Character/Hair.modulate = $Panel/Controls/Hair/ColorPicker.color

func _set_eyes(id: int) -> void:
	$Character.eyes = $Panel/Controls/Eyes/Type.get_item_text(id)
	$Character.load_sprite()

func _set_skintone(id: int) -> void:
	$Character.skintone = $Panel/Controls/Skintone/Type.get_item_text(id)
	$Character.load_sprite()

func _on_Done_pressed() -> void:
	Global.player["nickname"] = $Panel/Controls/Nickname/Text.text
	Global.player["sex"] = $Panel/Controls/Sex/Type.text
	Global.player["race"] = $Panel/Controls/Race/Type.text
	Global.player["skintone"] = $Panel/Controls/Skintone/Type.text
	Global.player["hair"] = $Panel/Controls/Hair/Type.text
	Global.player["hair_color"] = $Panel/Controls/Hair/ColorPicker.color
	Global.player["eyes"] = $Panel/Controls/Eyes/Type.text
	get_tree().change_scene("res://Scenes/UI/JoinHost.tscn")

func _on_Color_color_changed(color: Color) -> void:
	$Character/Hair.modulate = color
