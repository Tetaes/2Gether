extends Area2D

var occupied = false

#if players exit goal
func _on_Goal2_body_exited(body):
	if body.is_in_group('player'):
		occupied = false

#if players enter goal
func _on_Goal2_body_entered(body):
	if body.is_in_group('player'):
		occupied = true

