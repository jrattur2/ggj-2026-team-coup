class_name BattleLevel extends Node

#region Signal
signal on_win(player: PlayerInfo)
signal on_lose()
#endregion

var enemy_max_health := 3 #TODO could be part of Enemy resource
var enemy_current_health := enemy_max_health

var player_info: PlayerInfo = null

func init_battle(info: BattleStartInfo):
	player_info = info.playerInfo
	_update_health_label(player_info.health, player_info.max_health, %PlayerHPLabel)

# deal damage to enemy
func _deal_damage():
	enemy_current_health -= 1
	_update_health_label(enemy_current_health, enemy_max_health, %EnemyHPLabel)
	# TODO change sprite
	print_debug("damage taken")
	if enemy_current_health <= 0:
		print_debug("win")
		on_win.emit(player_info)

# player takes damage
func _take_damage():
	player_info.health -= 1
	_update_health_label(player_info.health, player_info.max_health, %PlayerHPLabel)
	if player_info.health <= 0:
		on_lose.emit()


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
