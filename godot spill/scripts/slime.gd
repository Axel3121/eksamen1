extends Node2D

var direction = 1
const SPEED = 60
@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castleft: RayCast2D = $RayCastleft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:
	if ray_castright.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h =true
	if ray_castleft.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta
