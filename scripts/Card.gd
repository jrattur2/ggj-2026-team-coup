class_name Card
extends Sprite2D

func _init(id: String, suit: String, rank: String, blackjack_rank: int, front_texture_file: String, rear_texture_file: String):
	self.id = id
	self.suit = suit
	self.rank = rank
	self.blackjack_rank = blackjack_rank
	self.front_texture_file = front_texture_file
	self.rear_texture_file = rear_texture_file
	face_up = false

var id: String
var suit: String
var rank: String
var blackjack_rank: int
var front_texture_file: String
var rear_texture_file: String
var face_up: bool
var previous_face_up_value: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	face_up = false
	previous_face_up_value = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if face_up != previous_face_up_value:
		if face_up:
			texture = load(front_texture_file)
		else:
			texture = load(rear_texture_file)
		previous_face_up_value = face_up
	pass
