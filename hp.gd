extends Label

var last_health = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Game.playerHP != last_health:
		if Game.playerHP < 0:
			Game.playerHP = 0
		update_health()

func update_health():
	text = "HP: " + str(Game.playerHP)
	last_health = Game.playerHP
