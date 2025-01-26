extends Area2D

signal level_completed  # Signal to notify when the player reaches the exit

func _on_body_entered(body):
	if body.name == "Player":  # Check if the player is the one entering the exit area
		emit_signal("level_completed")  # Trigger the level completed signal

func _on_exit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
