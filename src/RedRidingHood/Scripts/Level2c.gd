extends Node2D

enum GameRoute {NONE, CANON, OUTSMART, HAPPYEND}

@export var game_route: GameRoute = GameRoute.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match game_route:
		GameRoute.CANON:
			get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").start("dlg_canonend")
		GameRoute.OUTSMART:
			get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").start("dlg_outsmart")
		GameRoute.HAPPYEND:
			get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").start("dlg_happy")
		_:
			OS.alert("Ending not specified")
	get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").show()
	get_tree().root.get_node("Game/Player").talking = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_dialogue_box_dialogue_signal(value: String) -> void:
	match value:
		"end":
			$CanvasLayer/Control/AnimationPlayer.play("end_game")
		"wolf_appear":
			var wolf: Node2D = load("res://RedRidingHood/Assets/Wolf.tscn").instantiate()
			wolf.get_node("BigBadWolf").modulate = Color(0.0, 0.0, 0.0, 0.0)
			$WolfSpawn.add_child(wolf)
			var tween: Tween = wolf.create_tween()
			tween.tween_property(wolf.get_node("BigBadWolf"), "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0)
			tween.play()
			await get_tree().create_timer(1.0).timeout
			get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").start("dlg_outsmart_2")
			get_tree().root.get_node("Game/CanvasLayer/Control/DialogueBox").show()
	get_tree().root.get_node("Game/Player").talking = true

func load_last_scene_outsmart() -> void:
	Settings.change_scene("res://RedRidingHood/Scenes/Level3O.tscn")
