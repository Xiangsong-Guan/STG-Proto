extends Control

onready var fps_label: Label = get_node("FPS/N")
onready var bn_label: Label = get_node("BN/N")

var Scn: Node2D


func _process(delta: float) -> void:
	bn_label.text = str(Scn.bn)
	fps_label.text = str(Engine.get_frames_per_second())
	
	
func _enter_tree() -> void:
	Scn = get_parent().get_parent()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().paused = not get_tree().paused
		$Pause.visible = not $Pause.visible
		if $Dead.visible:
			$Dead.visible = false
			Scn.restart()
		accept_event()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_dead() -> void:
	$Dead.visible = true
	
	
func _on_boss_hp_changed(hp: int) -> void:
	$BossHP/N.text = str(hp)
	
	
	
	
	
	
	
	
	
	
	
	
	
