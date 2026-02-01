class_name Start
extends GameState

func enter_state():
	# Disable action buttons
	game.hit_button.disabled = true
	game.stand_button.disabled = true
	
	pass
	
func execute():
	if game.game_state == game.start:
		game.update_state(game.clear_all_cards)
	
func exit_state():
	pass
