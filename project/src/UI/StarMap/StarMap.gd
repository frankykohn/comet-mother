extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var redMenu = load("res://src/UI/StarMap/Assets/redMenu.png")
onready var greenMenu = load("res://src/UI/StarMap/Assets/greenMenu.png")
onready var dailyMenu = load("res://src/UI/StarMap/Assets/DailyMenuPage.png")
onready var foodMenuContainer = $GalaxyPicture/FoodMenuContainer
onready var menuSprite = $GalaxyPicture/FoodMenuContainer/VBoxContainer/stats
var spriteIndex = 0

func _ready():
	$StarMapAudio.play()

func _on_SquarePlanet_pressed():
	foodMenuContainer.visible = !foodMenuContainer.visible
	menuSprite.set_normal_texture(greenMenu)
	spriteIndex = 1
	
func _on_CirclePlanet_pressed():	
	foodMenuContainer.visible = !foodMenuContainer.visible
	menuSprite.set_normal_texture(greenMenu)
	spriteIndex = 2

func _on_TrianglePlanet_pressed():
	foodMenuContainer.visible = !foodMenuContainer.visible
	menuSprite.set_normal_texture(dailyMenu)
	spriteIndex = 3

func _on_stats_pressed():
	foodMenuContainer.visible = !foodMenuContainer.visible


func _on_start_pressed():
	get_tree().change_scene("res://src/World/Levels/Gameplay.tscn")
