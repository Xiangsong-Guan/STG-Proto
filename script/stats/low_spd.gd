extends "res://script/stats/stat_abs.gd"

const LaserCompRes := preload("res://script/comp/laser_comp.gd")
const Laser1Res := preload("res://bullet/Laser1.tscn")

const LOW_SPD := 100

var cache_spd := 0


func _init() -> void:
	var sp = Position2D.new()
	sp.position = Vector2(0, -50)
	scs.append(LaserCompRes.new(2, Laser1Res.instance(), sp))
	
	
func enable() -> void:
	cache_spd = Master.speed
	Master.speed = LOW_SPD
	.enable()
	
	
func disable() -> void:
	Master.speed = cache_spd
	.disable()
	
	
	
	
	
	
