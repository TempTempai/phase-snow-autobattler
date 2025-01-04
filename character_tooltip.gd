extends Control

class_name CharacterTooltip

@export var ability_info_scene : PackedScene
@export var name_label : Label
@export var ability_info_container : Container
@export var character : Character

var char_def : CharacterDefinition

var ability_infos : Array[AbilityInfo]

# TODO connect level up button signals
# TODO disable/enable level up buttons based on skill points

func _ready() -> void:
	character.skill_points_changed.connect(update_level_up_buttons)


func update_level_up_buttons(sp : int):
	for i in range(len(ability_infos)):
		var ability_level := character.ability_levels[i]
		var info := ability_infos[i]
		info.set_level_up_button_disabled(sp == 0 or info.is_max_level(ability_level))


func load_char_def(character_definition : CharacterDefinition):
	char_def = character_definition
	name_label.text = char_def.character_name
	for i in range(len(char_def.abilities)):
		var ability : AbilityDefinition = char_def.abilities[i]
		var ability_info : AbilityInfo = ability_info_scene.instantiate()
		ability_info_container.add_child(ability_info)

		ability_info.ability_def = ability
		ability_info.level = character.ability_levels[i]

		ability_infos.append(ability_info)
	update_level_up_buttons(character.skill_points)
