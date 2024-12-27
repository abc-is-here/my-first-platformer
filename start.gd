extends Control

var bob_height: float = 10.0
var bob_speed: float = 5.0

@onready var start_y: float = $Ghost.global_position.y
var t: float = 0.0

func _ready() -> void:
	$whisper.play()

func _process(delta: float) -> void:
	t+=delta
	var d = (sin(t*bob_speed) + 1)/2
	$Ghost.global_position.y = start_y + d*bob_height

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level1.tscn")
