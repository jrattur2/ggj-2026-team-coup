class_name MainMenu extends Control

signal on_main_menu_start_pressed()

@onready var main_menu: MainMenu = $"."

var master_bus_index := 0
var music_bus_index := 0
var sfx_bus_index := 0

enum GameLanguage {
	English,
	Japanese,
}

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider

var current_language := GameLanguage.English

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TranslationServer.set_locale("en")
	master_bus_index = AudioServer.get_bus_index("Master")
	master_slider.value = AudioServer.get_bus_volume_linear(master_bus_index)
	music_bus_index = AudioServer.get_bus_index("Music")
	music_slider.value = AudioServer.get_bus_volume_linear(music_bus_index)
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	sfx_slider.value = AudioServer.get_bus_volume_linear(sfx_bus_index)


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
	AudioServer.set_bus_volume_linear(master_bus_index, value)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_index, value)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)
