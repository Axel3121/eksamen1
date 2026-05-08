extends Area2D

@onready var gamemanger: Node = %gamemanger
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	gamemanger.add_point()
	animation_player.play("pickup")
