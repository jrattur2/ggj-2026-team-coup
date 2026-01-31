class_name PostsBattleMenu extends Control

const REWARD_SCENE_UID: String = "uid://c75sg7q60ookq"

#region helper types
enum RewardType {
	Heal,
	Passive,
	Active,
}

class Reward:
	var type: RewardType
	var value: Variant
	func _init(_type: RewardType, _value) -> void:
		type = _type
		match type:
			RewardType.Heal:
				assert(_value is int)
			#TODO don't use string
			RewardType.Passive:
				assert(_value is String)
			RewardType.Active:
				assert(_value is String)
		
		value = _value
#endregion

signal on_reward_chosen(reward: Reward)

@onready var chose_reward_button: Button = $ChoseRewardButton
@onready var reward_container: HBoxContainer = $RewardContainer

var selected_reward

func _ready() -> void:
	chose_reward_button.disabled = true

func populate_rewards(rewards: Array[Reward]):
	for child in reward_container.get_children():
		child.queue_free()
	
	for reward: Reward in rewards:
		var reward_scene: PackedScene = load(REWARD_SCENE_UID)
		assert(reward_scene)
		var reward_node: RewardContainer = reward_scene.instantiate()
		reward_container.add_child(reward_node)
		reward_node.create(reward)
		reward_node.on_selected.connect(_on_selection_changed)

func _on_selection_changed(reward: Reward):
	selected_reward = reward
	chose_reward_button.disabled = false

func _on_chose_reward_button_pressed() -> void:
	on_reward_chosen.emit(selected_reward)
