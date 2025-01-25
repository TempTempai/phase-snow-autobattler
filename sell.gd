extends Control


@onready var price_label : Label = %PriceLabel
@onready var box : PanelContainer = %SellContainer

var no_sale_text : String = "--"
var holding_sellable : bool = false

func _ready() -> void:
	GameState.drag_char_changed.connect(update_price)


func update_price(char: Character):
	if char == null or char.from_shop:
		holding_sellable = false
		price_label.text = no_sale_text
		set_box_scale(1)
		return
	price_label.text = str(char.sell_price)
	holding_sellable = true


func _on_panel_container_mouse_entered() -> void:
	GameState.drag_sell_button = true
	if holding_sellable:
		set_box_scale(1.05)

func _on_panel_container_mouse_exited() -> void:
	GameState.drag_sell_button = false
	if holding_sellable:
		set_box_scale(1)
	
func set_box_scale(val: float):
	if box.scale.x != val:
		box.scale = Vector2(val, val)
