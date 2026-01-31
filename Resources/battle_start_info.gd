class_name BattleStartInfo extends Resource

var playerInfo: PlayerInfo
var enemyInfo: Enemy

func _init(player: PlayerInfo, enemy: Enemy) -> void:
	playerInfo = player
	enemyInfo = enemy
