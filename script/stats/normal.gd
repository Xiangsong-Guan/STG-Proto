extends "res://script/stats/stat_abs.gd"

const ShootCompRes := preload("res://script/comp/shoot_comp.gd")
const Bullet1Res := preload("res://bullet/BulletP1.tscn")


func _init() -> void:
	var sp1 = Position2D.new()
	sp1.position = Vector2(0, -30)
	scs.append(ShootCompRes.new(10, Bullet1Res, sp1))
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
