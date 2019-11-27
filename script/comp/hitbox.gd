extends Area2D

class_name Hitbox

var Master: Node2D


func _enter_tree() -> void:
	Master = get_parent()
	
# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_hit")
# warning-ignore:return_value_discarded
	connect("area_entered", self, "_on_datie")
	
	
func _on_datie(a: Area2D) -> void:
	print("dang!")
	
	
func _on_hit(c: PhysicsBody2D) -> void:
	c.hitten(Master.damage)
