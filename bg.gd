extends ParallaxBackground

# Send offset to the left
var scrolling_speed = 100

func _process(delta):
		scroll_offset.x -= scrolling_speed * delta
