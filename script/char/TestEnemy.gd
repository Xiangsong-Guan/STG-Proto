extends "res://script/char/boss_abs.gd"

const ShootCompRes := preload("res://script/comp/shoot_comp.gd")
const Bullet1Res := preload("res://bullet/BulletE1.tscn")

var Target: Node2D

var timer := Timer.new()


func _init() -> void:
	init_hp = 30
	change_hp(init_hp - hp)


func _enter_tree() -> void:
	timer.one_shot = true
	add_child(timer)


func _ready()-> void:
	var sp1 = Position2D.new()
	var sp2 = Position2D.new()
	sp1.position = Vector2(-26, -38)
	sp2.position = Vector2(26, -38)
	scs.append(ShootCompRes.new(15, Bullet1Res, sp1, {interval = .3, speed = 300, snipe = true}))
	scs.append(ShootCompRes.new(150, Bullet1Res, sp2, {interval = .2, speed = 200, angles = [.0,PI/5,2*PI/5,3*PI/5,4*PI/5,5*PI/5,6*PI/5,7*PI/5,8*PI/5,9*PI/5]}))
	for sc in scs:
		add_child(sc)
	scs_active.append(scs[0])
	scs_active.append(scs[1])
	
	
func _process(delta: float) -> void:
	scs[1].shift(delta)


func explosion() -> void:
	.explosion()
	movement = Vector2.ZERO
	speed = 0
	modulate = Color(.1, .1, .1, .5)
	Engine.time_scale = .5
	timer.stop()
	timer.start(1)
	yield(timer, "timeout")
	Engine.time_scale = 1
	
	
func reborn() -> void:
	.reborn()
	modulate = Color(1, 1, 1, 1)
	
	
func start(target: Node2D = null) -> void:
	.start()
	
	Target = target
	movement = Vector2.DOWN
	speed = 150
	timer.start(2)
	yield(timer, "timeout")
	if hp < 1: return

	shoot(Target)
	movement = Vector2.UP
	speed = 300
	timer.start(.5)
	yield(timer, "timeout")
	if hp < 1: return

	movement = Vector2.LEFT
	speed = 200
	timer.start(1)
	yield(timer, "timeout")
	if hp < 1: return

	movement = Vector2.ZERO
	speed = 100
	timer.wait_time = 4
	while hp > 0:
		movement = Vector2.RIGHT
		timer.start()
		yield(timer, "timeout")
		if hp < 1: return
		movement = Vector2.LEFT
		timer.start()
		yield(timer, "timeout")
		if hp < 1: return
	movement = Vector2.ZERO
	speed = 0









