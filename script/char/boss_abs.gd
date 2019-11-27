extends "res://script/char/char_abs.gd"

class_name BossABS

signal hp_changed


func shoot(target: Node2D = null) -> void:
	for sc in scs_active:
		sc.shoot(target)


func cease() -> void:
	for sc in scs_active:
		sc.cease()


func explosion() -> void:
	.explosion()
	for sc in scs_active:
		sc.ash()


func change_hp(value: int) -> void:
	.change_hp(value)
	emit_signal("hp_changed", hp)
	
	
func start() -> void:
	change_hp(0)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
