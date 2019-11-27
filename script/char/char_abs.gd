extends Node2D

class_name CharABS

signal char_died

var full_power: int = 10
var speed: int = 300

var init_hp: int = 1
var init_power: int = 1
var init_def: int = 0
var hp: int = init_hp
var power: int = init_power
var def: int = init_def

var movement: Vector2

var scs: Array = []
var scs_active: Array = []


func _physics_process(delta) -> void:
	_physics_process_override(delta)
	
	
func _physics_process_override(delta: float) -> void:
	position += movement.normalized() * speed * delta
	
	
func reborn() -> void:
	change_hp(init_hp - hp)
	power = init_power
	def = init_def
	
	
func hurt(damage: int) -> bool:
	var change: int = def - damage 
	var flag = change < 0
	if flag: change_hp(change)
	return flag


func change_hp(value: int) -> void:
	hp += value
	if hp <= 0:
		explosion()
		emit_signal("char_died")
		
		
func explosion() -> void:
	def = 1573
	
	
	
	
	
	
	
	
