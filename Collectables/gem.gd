extends Area2D

func _ready() -> void:
	get_node("AnimatedSprite2D").play("Idle")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Game.Gold += 1
		
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 20), .3)
		tween1.tween_property(self, "modulate:a", 0, .3)
		tween.tween_callback(queue_free)
