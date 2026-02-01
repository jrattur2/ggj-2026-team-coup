class_name Evaluate
extends GameState

var timer_start_time: float = 0.0
@onready var player_active_modifiers: Node2D = %ActivePlayerModifiers

enum EndRoundState { PLAYER_WIN, PLAYER_LOSE, DRAW }

func enter_state():
	
	timer_start_time = Time.get_ticks_msec()
	
	# Reveal dealer's hidden card
	var dealer_cards = game.get_hand_cards(game.dealer_hand)
	for card in dealer_cards:
		card.face_up = true
	
	var player_value_min = game.calculate_hand_value(game.player_hand)[0]
	var player_value_max = game.calculate_hand_value(game.player_hand)[1]
	var dealer_value_min = game.calculate_hand_value(game.dealer_hand)[0]
	var dealer_value_max = game.calculate_hand_value(game.dealer_hand)[1]
	
	var player_score = player_value_max if player_value_max <= 21 else player_value_min
	var dealer_score = dealer_value_max if dealer_value_max <= 21 else dealer_value_min
	
	var player_blackjack = (player_value_min == 21 or player_value_max == 21) and game.player_hand.get_children().size() == 2
	var dealer_blackjack = (dealer_value_min == 21 or dealer_value_max == 21) and game.dealer_hand.get_children().size() == 2
	
	var player_bust = true if player_score > 21 else false
	var dealer_bust = true if dealer_score > 21 else false

	var end_round_state
	
	if player_score == dealer_score:
		end_round_state = EndRoundState.DRAW
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.Tie])
	
	if player_bust and not dealer_bust:
		end_round_state = EndRoundState.PLAYER_LOSE
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.PlayerBust])

	if dealer_bust and not player_bust:
		end_round_state = EndRoundState.PLAYER_WIN
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.DealerBust])
	
	elif player_blackjack and not dealer_blackjack:
		end_round_state = EndRoundState.PLAYER_WIN
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.PlayerWin])
		
	elif dealer_blackjack and not player_blackjack:
		end_round_state = EndRoundState.PLAYER_LOSE
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.DealerWin])
	
	elif player_score > dealer_score:
		end_round_state = EndRoundState.PLAYER_WIN
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.PlayerWin])
		
	elif player_score < dealer_score:
		end_round_state = EndRoundState.PLAYER_LOSE
		game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.DealerWin])
	
	var damage_multiplier: int = 1;
	for modifier: Modifier in player_active_modifiers.get_children():
		if modifier is DoubleDamage:
			damage_multiplier = 2
			modifier.queue_free()
	
	if end_round_state == EndRoundState.PLAYER_WIN:
		var score_difference = abs(player_score - dealer_score)
		game.dealer_take_damage(score_difference * 10 * damage_multiplier)
		
	if end_round_state == EndRoundState.PLAYER_LOSE:
		var score_difference = abs(dealer_score - player_score)
		game.player_take_damage(score_difference * 10 * damage_multiplier)
	
	if end_round_state == EndRoundState.DRAW:
		print('Draw, no damage done')
	
	pass

func execute():
	if game.game_state == game.evaluate and Time.get_ticks_msec() > (timer_start_time + 4000):
		game.update_state(game.clear_all_cards)

func exit_state():
	pass
