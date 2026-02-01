class_name BattleLevel extends Node

enum EnemyType {
	Dog,
	Frog,
	Mouse
}

#region Signal
signal on_win(player: PlayerInfo)
signal on_lose()
#endregion

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var enemy_head: Sprite2D = %EnemyHead
@onready var game: Game = $GameStates/Game

@onready var hit_sfx: AudioStreamPlayer = %HitSfx
@onready var break_sfx: AudioStreamPlayer = %BreakSfx
@onready var take_damage_sfx: AudioStreamPlayer = %TakeDamageSfx
@onready var enemy_dead_sfx: AudioStreamPlayer = %EnemyDeadSfx

var sprite_default: Texture2D
var sprite_damage1: Texture2D
var sprite_damage2: Texture2D
var sprite_inside: Texture2D
var destro_anim_name: String

var enemy_max_health := 3 #TODO could be part of Enemy resource
var enemy_current_health := enemy_max_health
var enemy_type: EnemyType = EnemyType.Dog

var player_info: PlayerInfo = null

func init_battle(info: BattleStartInfo):
	player_info = info.playerInfo
	enemy_type = EnemyType.Dog if info.enemyInfo.name == "dog" else EnemyType.Frog
	print_debug("fighting ", info.enemyInfo.name)
	enemy_head.texture = sprite_default
	_update_health_label(player_info.health, player_info.max_health, %PlayerHPLabel)

func update_damage_visual(health: int):
	print_debug("updating visual")
	
	if health <= 0:
		animated_sprite_2d.show()
		
		break_sfx.play()
		enemy_dead_sfx.play()

		enemy_head.texture = sprite_inside
		if !animated_sprite_2d.animation_finished.is_connected(_destoy_anim_finished):
			animated_sprite_2d.animation_finished.connect(_destoy_anim_finished)
		animated_sprite_2d.play(destro_anim_name)
		return
	
	hit_sfx.play()
	
	if health < 30:
		enemy_head.texture = sprite_damage2
		return
	
	if health < 60:
		enemy_head.texture = sprite_damage1
		return

# deal damage to enemy
func _deal_damage():
	game.dealer_take_damage(13)

# player takes damage
func _take_damage():
	game.player_take_damage(13)

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
