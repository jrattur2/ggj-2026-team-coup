class_name Deal
extends GameState

var game: Game

func enter_state():
	
	var card1: Card = game.deck.get_children().back();
	game.move_card(card1 ,game.deck, game.player_1_card_1)
	card1.face_up = true
	
	var card2: Card = game.deck.get_children().back();
	game.move_card(card2 ,game.deck, game.player_2_card_1)
	card2.face_up = true
	
	var card3: Card = game.deck.get_children().back();
	game.move_card(card3 ,game.deck, game.player_1_card_2)
	card3.face_up = true
	
	var card4: Card = game.deck.get_children().back();
	game.move_card(card4 ,game.deck, game.player_2_card_2)
	card4.face_up = false
	
	game.update_state(game.player_turn)
	
	pass
	
func exit_state():
	pass
