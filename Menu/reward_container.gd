class_name RewardContainer extends Control

signal on_selected(selection: PostsBattleMenu.Reward)

@onready var name_label: Label = $Button/VBoxContainer/NameLabel
@onready var effect_label: Label = $Button/VBoxContainer/EffectLabel

var reward: PostsBattleMenu.Reward

# Called when the node enters the scene tree for the first time.
func create(_reward: PostsBattleMenu.Reward) -> void:
	reward = _reward
	match reward.type:
		PostsBattleMenu.RewardType.Heal:
			name_label.tr("REWARD_HEAL_NAME")
			effect_label.tr("REWARD_HEAL_EFFECT").format({"value" : reward.value})
		PostsBattleMenu.RewardType.Passive:
			var name_key := "REWARD_{}_NAME".format("TEST")
			var effect_key := "REWARD_{}_EFFECT".format("TEST")
			name_label.tr(name_key)
			effect_label.tr(effect_key)
		PostsBattleMenu.RewardType.Active:
			var name_key := "REWARD_{}_NAME".format("TEST")
			var effect_key := "REWARD_{}_EFFECT".format("TEST")
			name_label.tr(name_key)
			effect_label.tr(effect_key)

func _on_button_pressed() -> void:
	on_selected.emit(reward)
