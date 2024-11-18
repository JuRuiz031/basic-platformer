extends Label

var last_gold = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_gold()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Game.Gold != last_gold:
		update_gold()

func update_gold():
	text = "Gold: " + str(Game.Gold)
	last_gold = Game.Gold
