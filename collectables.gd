extends Node2D

var Gem = preload("res://Collectables/Gem.tscn")


func _on_timer_timeout() -> void:
	var gemTemp = Gem.instantiate()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randInt = rng.randi_range(26, 1105)
	gemTemp.position = Vector2(randInt, 263)
	add_child(gemTemp)
