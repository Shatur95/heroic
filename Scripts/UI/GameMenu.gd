extends Control

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_visible_in_tree():
			visible = false
		else:
			visible = true

func _on_Settings_pressed():
	pass # Settings? We don't need settings.

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")

func _on_Quit_pressed():
	get_tree().quit()