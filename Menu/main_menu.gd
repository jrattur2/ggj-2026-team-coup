class_name MainMenu extends Control

const GAME_SCENE_UID := "TODO"
@onready var main_menu: MainMenu = $"."

enum GameLanguage {
	English,
	Japanese,
}

var current_language := GameLanguage.English

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TranslationServer.set_locale("en")

func change_language(new_language : GameLanguage):
	if new_language == current_language:
		return
	
	var locale = "en" if new_language == GameLanguage.English else "ja"
	TranslationServer.set_locale(locale)
	current_language = new_language

func _on_start_button_pressed() -> void:
	var game_scene : PackedScene = load(GAME_SCENE_UID)
	assert(game_scene, "failed to load game")
	var loaded_scene := game_scene.instantiate()
	assert(loaded_scene, "failed to instatiate scene")
	get_tree().root.add_child(loaded_scene)
	main_menu.hide()


func _on_en_button_pressed() -> void:
	change_language(GameLanguage.English)

func _on_ja_button_pressed() -> void:
	change_language(GameLanguage.Japanese)

func _on_master_slider_value_changed(value: float) -> void:
	pass # Replace with function body.

func _on_music_slider_value_changed(value: float) -> void:
	pass # Replace with function body.

func _on_sfx_slider_value_changed(value: float) -> void:
	pass # Replace with function body.
