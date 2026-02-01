class_name BattleLevel extends Node

enum EnemyType {
	Dog,
	Frog
}

#region Signal
signal on_win(player: PlayerInfo)
signal on_lose()
#endregion

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var frog_head: Sprite2D = %FrogHead
@onready var dog_head: Sprite2D = %DogHead
@onready var game: Game = $GameStates/Game

const CRACKED_DOG_MASK_1 = preload("uid://do52u8xtka1ei")
const CRACKED_DOG_MASK_2 = preload("uid://ja1s8lbfrl45")
const DOG_INSIDE = preload("uid://dgmekw0yk5786")
const CRACKED_FROG_MASK_1 = preload("uid://bk3pdoxnlfnnm")
const CRACKED_FROG_MASK_2 = preload("uid://cgvte1akgvvir")
const FROG_INSIDE = preload("uid://cn7ymj5putr71")

var enemy_max_health := 3 #TODO could be part of Enemy resource
var enemy_current_health := enemy_max_health
var enemy_type: EnemyType = EnemyType.Dog

var player_info: PlayerInfo = null

func init_battle(info: BattleStartInfo):
	player_info = info.playerInfo
	enemy_type = EnemyType.Dog if info.enemyInfo.name == "dog" else EnemyType.Frog
	print_debug("fighting ", info.enemyInfo.name)
	_update_health_label(player_info.health, player_info.max_health, %PlayerHPLabel)
	show_enemy(enemy_type)

func show_enemy(type: EnemyType):
	match type:
		EnemyType.Dog:
			frog_head.hide()
			dog_head.show()
		EnemyType.Frog:
			dog_head.hide()
			frog_head.show()

func update_damage_visual(health: int):
	print_debug("updateing visual")
	var sprite: Texture2D = null
	var head: Sprite2D = %DogHead if enemy_type == EnemyType.Dog else %FrogHead
	if health <= 0:
		animated_sprite_2d.show()
		animated_sprite_2d.animation_finished.connect(_destoy_anim_finished)
		match enemy_type:
			EnemyType.Dog:
				head.texture = DOG_INSIDE
				animated_sprite_2d.play("dog_mask_destroy")
			EnemyType.Frog:
				head.texture = FROG_INSIDE
				animated_sprite_2d.play("frog_mask_destroy")
		return
		
	if health < 30:
		match enemy_type:
			EnemyType.Dog:
				sprite = CRACKED_DOG_MASK_2
			EnemyType.Frog:
				sprite = CRACKED_FROG_MASK_2
	elif health < 60:
		match enemy_type:
			EnemyType.Dog:
				sprite = CRACKED_DOG_MASK_1
			EnemyType.Frog:
				sprite = CRACKED_FROG_MASK_1
	
	if sprite:
		match enemy_type:
			EnemyType.Dog:
				head.texture = sprite
			EnemyType.Frog:
				head.texture = sprite

# deal damage to enemy
func _deal_damage():
	game.dealer_take_damage(10)

# player takes damage
func _take_damage():
	player_info.health -= 1
	_update_health_label(player_info.health, player_info.max_health, %PlayerHPLabel)
	if player_info.health <= 0:
		on_lose.emit()

func _destoy_anim_finished():
	on_win.emit(player_info)

func _update_health_label(new_health: int, max_health: int, label: Label):
	
	label.text = "{0} / {1}".format([str(new_health), str(max_health)])

func _unhandled_input(event: InputEvent) -> void:
	if OS.has_feature("debug"):
		if event.is_action_pressed("dev_win_turn"):
			_deal_damage()
		elif event.is_action_pressed("dev_win_match"):
			on_win.emit()
		elif event.is_action_pressed("dev_lose_turn"):
			_take_damage()
		elif event.is_action_pressed("dev_lose_match"):
			on_lose.emit()
