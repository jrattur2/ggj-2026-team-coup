class_name ClearAllCards
extends GameState

func enter_state():
	print('Deleting all cards')
	
	delete_children(game.deck)
	delete_children(game.player_1_card_1)
	delete_children(game.player_2_card_1)	

	game.start_next_round()

func execute():
	if game.game_state == game.clear_all_cards:
		game.update_state(game.build_deck)

func exit_state():
	pass
	
func delete_children(node: Node):
	for child in node.get_children():
		child.queue_free()
