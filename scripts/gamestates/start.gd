class_name Start
extends GameState

func enter_state():
	game.player_turn_text.text = 'Press Deal to start'
	game.score_text.text = 'Ready to play'
	
	# Disable action buttons
	var hit_button: Button = get_node("/root/level/Hit")
	var stand_button: Button = get_node("/root/level/Stand")
	hit_button.disabled = true
	stand_button.disabled = true
	
	# Enable deal button
	var deal_button: Button = get_node("/root/level/Deal_Button")
	deal_button.disabled = false
	
	pass
	
func exit_state():
	pass
