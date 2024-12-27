extends Area2D

@export_file("*.tscn") var next_scene
var level_no: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_scene)
