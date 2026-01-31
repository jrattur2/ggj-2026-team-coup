extends Node

enum GameState { START, DEAL, PLAYER_TURN, DEALER_TURN, END_ROUND }

var gameState: GameState = GameState.START

func update_state(new_state: GameState):
	self.gameState = gameState
	print('Entering state ' + str(gameState))



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
