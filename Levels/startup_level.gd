class_name GameManager extends Node

const BATTLE_LEVEL_UID := "uid://ywwy2ltilu4v"

@export var enemies: Array[Enemy]

@onready var main_menu: MainMenu = $MainMenu
@onready var ingame: Node = $Ingame
@onready var reward_menu: PostsBattleMenu = $RewardMenu
@onready var win_screen: Control = $WinScreen
@onready var lose_screen: Control = $LoseScreen
@onready var title_bg: TextureRect = %TitleBG
@onready var battle_bg: TextureRect = %BattleBG
@onready var music_player: AudioStreamPlayer = %MusicPlayer
@onready var restart_button: Button = %RestartButton

var mouse_sprites: Array[String] = [
	"res://assets/enemies/mouse/cracked_lat_mask_1.png",
	"res://assets/enemies/mouse/cracked_lat_mask_2.png",
	"res://assets/enemies/mouse/lat_inside.png",
	"res://assets/enemies/mouse/lat_mask.png",
	"mouse_mask_destroy"
]
var dog_sprites: Array[String] = [
	"res://assets/enemies/dog/cracked_dog_mask_1.png",
	"res://assets/enemies/dog/cracked_dog_mask_2.png",
	"res://assets/enemies/dog/dog_inside.png",
	"res://assets/enemies/dog/dog_mask.png",
	"dog_mask_destroy"
]
var frog_sprites: Array[String] = [
	"res://assets/enemies/frog/cracked_frog_mask_1.png",
	"res://assets/enemies/frog/cracked_frog_mask_2.png",
	"res://assets/enemies/frog/frog_inside.png",
	"res://assets/enemies/frog/frog_mask.png",
	"frog_mask_destroy"
]

var player : PlayerInfo
var current_battle: BattleLevel = null

func _ready() -> void:
	main_menu.show()
	reward_menu.hide()
	win_screen.hide()
	lose_screen.hide()
	battle_bg.hide()
	title_bg.show()
	restart_button.hide()
	
	main_menu.on_main_menu_start_pressed.connect(_on_start_pressed)

func _on_start_pressed():
	main_menu.hide()
	player = PlayerInfo.new(
		3,
		3,
		["passive effect that doubles every draw number"],
		["1", "2"],
		["1-time effect that lets you discard your hand and draw new"]
	)
	enemies.shuffle()
	var enemy: Enemy = enemies.pop_back()
	_load_battle(BattleStartInfo.new(player, enemy))
	
func _load_battle(info: BattleStartInfo):
	var battle_scene: PackedScene = load(BATTLE_LEVEL_UID)
	assert(battle_scene)
	current_battle = battle_scene.instantiate()
	assert(current_battle)
	ingame.add_child(current_battle, true)
	
	title_bg.hide()
	battle_bg.show()
	music_player.play()
	
	match info.enemyInfo.name:
		"dog":
			current_battle.sprite_damage1 = load(dog_sprites[0])
			current_battle.sprite_damage2 = load(dog_sprites[1])
			current_battle.sprite_inside = load(dog_sprites[2])
			current_battle.sprite_default = load(dog_sprites[3])
			current_battle.destro_anim_name = dog_sprites[4]
		"mouse":
			current_battle.sprite_damage1 = load(mouse_sprites[0])
			current_battle.sprite_damage2 = load(mouse_sprites[1])
			current_battle.sprite_inside = load(mouse_sprites[2])
			current_battle.sprite_default = load(mouse_sprites[3])
			current_battle.destro_anim_name = mouse_sprites[4]
		"frog":
			current_battle.sprite_damage1 = load(frog_sprites[0])
			current_battle.sprite_damage2 = load(frog_sprites[1])
			current_battle.sprite_inside = load(frog_sprites[2])
			current_battle.sprite_default = load(frog_sprites[3])
			current_battle.destro_anim_name = frog_sprites[4]
	
	_connect_battle_signals(current_battle)
	current_battle.init_battle(info)

func _on_battle_win(player_info: PlayerInfo):
	player = player_info
	_disconnect_battle_signals(current_battle)
	
	for node: Node in ingame.get_children():
		node.queue_free()
	
	if enemies.is_empty():
		win_screen.show()
		restart_button.show()
		return
	
	reward_menu.on_reward_chosen.connect(_on_reward_chosen)
	reward_menu.populate_rewards(
		[
			PostsBattleMenu.Reward.new(PostsBattleMenu.RewardType.Heal, 3)
		]
	)
	reward_menu.show()

func _on_battle_lose():
	_disconnect_battle_signals(current_battle)
	for node: Node in ingame.get_children():
		node.queue_free()
	lose_screen.show()
	restart_button.show()

func _connect_battle_signals(battle: BattleLevel):
	battle.on_win.connect(_on_battle_win)
	battle.on_lose.connect(_on_battle_lose)

func _disconnect_battle_signals(battle: BattleLevel):
	if battle.on_win.is_connected(_on_battle_win):
		battle.on_win.disconnect(_on_battle_win)
	if battle.on_lose.is_connected(_on_battle_lose):
		battle.on_lose.disconnect(_on_battle_lose)
	current_battle = null

## The passed reward will vary depending on type
func _on_reward_chosen(reward: PostsBattleMenu.Reward):
	reward_menu.hide()
	if reward_menu.on_reward_chosen.is_connected(_on_reward_chosen):
		reward_menu.on_reward_chosen.disconnect(_on_reward_chosen)
	
	match reward.type:
		PostsBattleMenu.RewardType.Heal:
			assert(reward.value is int)
			player.health += reward.value
		PostsBattleMenu.RewardType.Passive:
			#TODO change type
			assert(reward.value is String)
			player.passive_modifiers.push_back(reward.value)
		PostsBattleMenu.RewardType.Active:
			#TODO change type
			assert(reward.value is String)
			player.extra_cards.push_back(reward.value)
	
	var next_enemy: Enemy = enemies.pop_back()
	assert(next_enemy)
	_load_battle(BattleStartInfo.new(player, next_enemy))

func _unhandled_input(event: InputEvent) -> void:
	if OS.has_feature("debug"):
		if event.is_action_pressed("dev_exit"):
			get_tree().quit()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
