extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialogue_box_dialogue_signal(value: String) -> void:
	match value:
		"wolf_deny":
			#Settings.route = Settings.GameRoute.HAPPYEND
			var tween: Tween = create_tween()
			tween.tween_property($Wolf, "modulate", Color(0, 0, 0, 0), 1.0)
			tween.play()
			await tween.finished
			$Wolf.queue_free()
			$Player.cutscene = true
			$Player.direction = 1.0
			tween = create_tween()
			tween.tween_property($CanvasLayer/Control/Fade, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2.0)
			tween.play()
			await get_tree().create_timer(2.0).timeout
			Settings.change_scene("res://RedRidingHood/Scenes/Level2H.tscn")
		"wolf_faster_canon":
			#Settings.route = Settings.GameRoute.CANON
			$Wolf.direction = 1.0
			await get_tree().create_timer(2.0).timeout
			$Player.cutscene = true
			$Player.direction = 1.0
			var tween: Tween = create_tween()
			tween.tween_property($CanvasLayer/Control/Fade, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2.0)
			tween.play()
			await get_tree().create_timer(2.0).timeout
			Settings.change_scene("res://RedRidingHood/Scenes/Level2C.tscn")
		"wolf_slower_outsmart":
			#Settings.route = Settings.GameRoute.OUTSMART
			$Wolf.direction = 1.0
			await get_tree().create_timer(2.0).timeout
			$Player.cutscene = true
			$Player.direction = 1.0
			var tween: Tween = create_tween()
			tween.tween_property($CanvasLayer/Control/Fade, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2.0)
			tween.play()
			await get_tree().create_timer(2.0).timeout
			Settings.change_scene("res://RedRidingHood/Scenes/Level2O.tscn")
	


func _on_no_way_back_body_entered(body: Node2D) -> void:
	if body is PlayerScript:
		get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").start("dlg_nwb")
		get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").show()
