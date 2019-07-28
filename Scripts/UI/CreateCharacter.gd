extends Control

func _ready() -> void:
	randomize_character()
	$Character/Animation.play_directional_animation("Walk")

func _check_nickname(nickname: String) -> void:
	$Character.game_name = nickname
	$Done.disabled = nickname.empty()

func randomize_character() -> void:
	var sex : int = randi() % $Panel/GridContainer/Sex.get_item_count()
	var race : int = randi() % $Panel/GridContainer/Race.get_item_count()
	var hair : int = randi() % $Panel/GridContainer/Hair.get_item_count()
	var hair_color : Color = Color(randf(), randf(), randf())
	var eyes_color : Color = Color(randf(), randf(), randf())
	
	# Set data in controls
	$Panel/GridContainer/Sex.select(sex)
	$Panel/GridContainer/Race.select(race)
	$Panel/GridContainer/Hair.select(hair)
	$Panel/GridContainer/HairColor.color = hair_color
	$Panel/GridContainer/Eyes.color = eyes_color
	
	# Update player
	set_sex(sex)
	set_race(race)
	set_hair(hair)
	set_hair_color(hair_color)
	set_eyes_color(eyes_color)

func set_sex(id: int) -> void:
	# Disable some hairs for male (id = 0)
	for i in range(17, 30):
		$Panel/GridContainer/Hair.set_item_disabled(i, !id)
	
	# Check if character has wrong hair
	if id == 0 and $Panel/GridContainer/Hair.selected >= 17:
		$Panel/GridContainer/Hair.selected = 16
		$Character.hair = $Panel/GridContainer/Hair.get_item_text(16)
	
	$Character.sex = $Panel/GridContainer/Sex.get_item_text(id)

func set_race(id: int) -> void:
	$Character.race = $Panel/GridContainer/Race.get_item_text(id)

func set_hair(id: int) -> void:
	$Character.hair = $Panel/GridContainer/Hair.get_item_text(id)

func set_hair_color(color: Color) -> void:
	$Character.hair_color = color

func set_eyes_color(color: Color) -> void:
	$Character.eyes = color

func _change_skintone_color(color: Color) -> void:
	$Character.skintone = color

func done() -> void:
	Global.player = $Character.data() # Save properties
	get_tree().change_scene("res://Scenes/UI/JoinHost.tscn")
