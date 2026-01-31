class_name GameManager extends Node

const BATTLE_LEVEL_UID := "uid://ywwy2ltilu4v"

@export var enemies: Array[Enemy]

@onready var main_menu: MainMenu = $MainMenu
@onready var ingame: Node = $Ingame
@onready var reward_menu: PostsBattleMenu = $RewardMenu

var player : PlayerInfo
var current_battle: BattleLevel = null

func _ready() -> void:
	main_menu.show()
	reward_menu.hide()
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
	ingame.add_child(current_battle)
	_connect_battle_signals(current_battle)
	current_battle.init_battle(info)

func _on_battle_win(player_info: PlayerInfo):
	player = player_info
	_disconnect_battle_signals(current_battle)
	
	for node: Node in ingame.get_children():
		node.queue_free()
	
	if enemies.is_empty():
		print_debug("you win")
	else:
		reward_menu.on_reward_chosen.connect(_on_reward_chosen)
		reward_menu.show()

func _on_battle_lose():
	_disconnect_battle_signals(current_battle)
	print_debug("you lose")

func _connect_battle_signals(battle: BattleLevel):
	battle.on_win.connect(_on_battle_win)
	battle.on_lose.connect(_on_battle_lose)

func _disconnect_battle_signals(battle: BattleLevel):
	if battle.on_win.is_connected(_on_battle_win):
		battle.on_win.disconnect(_on_battle_win)
	if battle.on_lose.is_connected(_on_battle_lose):
		battle.on_lose.disconnect(_on_battle_lose)
	current_battle = null


func _on_reward_chosen(reward: String):
	reward_menu.hide()
	if reward_menu.on_reward_chosen.is_connected(_on_reward_chosen):
		reward_menu.on_reward_chosen.disconnect(_on_reward_chosen)
	#TODO pass card instead of string?
	if reward == "passive":
		player.passive_modifiers.push_back(reward)
	elif reward == "active":
		player.extra_cards.push_back(reward)
	var next_enemy: Enemy = enemies.pop_back()
	assert(next_enemy)
	_load_battle(BattleStartInfo.new(player, next_enemy))

func _unhandled_input(event: InputEvent) -> void:
	if OS.has_feature("debug"):
		if event.is_action_pressed("dev_exit"):
			get_tree().quit()
