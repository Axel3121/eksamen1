extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("you died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	
	# Hent poeng og tid fra gamemanger
	var gm = get_node("/root/game/gamemanger")
	var poeng = gm.score
	var tid = Time.get_ticks_msec() / 1000.0
	
	# Lagre highscore
	var game = get_node("/root/game")
	game.lagre_highscore("Spiller1", poeng, tid)
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
