extends KinematicBody2D

class_name Hurtbox

var Master: CharABS


func _enter_tree() -> void:
	Master = get_parent()


func hitten(value: int) -> bool:
	return Master.hurt(value)

#extends Area2D
#
#class_name Hurtbox
#
#var Master: Node2D
#
#
#func _enter_tree():
#	Master = get_parent()
#
#	connect("body_entered", self, "_on_hit")
#
#
#func _on_hit(hitter):
#	hitter.hit()
#	Master.hurt(hitter.damage)
