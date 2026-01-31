class_name MainMenu extends Control

signal on_main_menu_start_pressed()

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
	on_main_menu_start_pressed.emit()


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
