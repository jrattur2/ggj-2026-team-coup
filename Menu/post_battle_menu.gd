class_name PostsBattleMenu extends Control

#TODO not string?
signal on_reward_chosen(choice:String)

func populate_rewards():
	pass


func _on_chose_reward_button_pressed() -> void:
	var choice := "something"
	on_reward_chosen.emit(choice)
