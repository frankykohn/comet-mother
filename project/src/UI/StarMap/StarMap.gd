extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var redMenu = load("res://src/UI/StarMap/Assets/redMenu.png")
onready var greenMenu = load("res://src/UI/StarMap/Assets/greenMenu.png")
onready var dailyMenu = load("res://src/UI/StarMap/Assets/DailyMenuPage.png")
onready var foodMenuContainer = $GalaxyPicture/FoodMenuContainer
onready var menuSprite = $GalaxyPicture/FoodMenuContainer/VBoxContainer/stats

func _ready():
	$StarMapAudio.play()

func _on_SquarePlanet_pressed():
	foodMenuContainer.visible = !foodMenuContainer.visible
	menuSprite.set_normal_texture(redMenu)
	


func _on_CirclePlanet_pressed():	
	foodMenuContainer.visible = !foodMenuContainer.visible
	menuSprite.set_normal_texture(greenMenu)


func _on_TrianglePlanet_pressed():
	foodMenuContainer.visible = !foodMenuContainer.visible
	menuSprite.set_normal_texture(dailyMenu)


func _on_stats_pressed():
	foodMenuContainer.visible = !foodMenuContainer.visible


func _on_return_pressed():
	$BackAudio.play()
	get_tree().change_scene("res://src/UI/MainMenu/TitleScreen.tscn")


func _on_start_pressed():
	get_tree().change_scene("res://src/World/Levels/Gameplay.tscn")
