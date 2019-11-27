extends Node

class_name StatABS

var Master: CharABS

var scs: Array = []


func armed(mstr: CharABS) -> void:
	for sc in scs:
		mstr.add_child(sc)
	Master = mstr


func disable() -> void:
	for sc in scs:
		sc.unformation()
	
	
func enable() -> void:
	for sc in scs:
		sc.formation()
	
	
func shoot() -> void:
	for sc in scs:
		sc.shoot()
	
	
func cease() -> void:
	for sc in scs:
		sc.cease()
		
		
		
		
