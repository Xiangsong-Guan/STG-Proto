extends Node2D

class_name LaserComp

class LaserCounter extends Area2D:
	var collision := CollisionShape2D.new()
	var cshape := RectangleShape2D.new()
	var power: int
	var Master: CharABS
	func _init(p: int, w: float) -> void:
		cshape.extents = Vector2(w, 0)
		power = p
		collision.shape = cshape
		collision_layer = pow(2, 15) # shell
		collision_mask = 0 # nothing
		collision.disabled = true
	func _enter_tree() -> void:
		add_child(collision)
		Master = get_parent().Master
	func counter(other_power: int) -> int:
		return other_power - (power * Master.power)
	func shift2(head: Vector2) -> void:
		collision.position = head / 2
		cshape.extents.y = collision.position.length()
		
		
var MAX_DISTANCE: int = 600

var Laser: LaserABS

var Master: CharABS

var ray := RayCast2D.new()
var counter: LaserCounter


func _init(c_mask: int, laser: LaserABS, s_pos: Position2D) -> void:
	Laser = laser
	
	position = s_pos.position
	rotation = s_pos.rotation
	
	ray.collision_mask = c_mask + pow(2, 15) # shell
	ray.collide_with_areas = true
	ray.cast_to = Vector2.UP * MAX_DISTANCE
	
	counter = LaserCounter.new(laser.power, laser.wide)
	ray.add_exception(counter)


func _enter_tree() -> void:
	Master = get_parent()
	add_child(ray)
	add_child(counter)
	add_child(Laser)
		
		
func _physics_process(delta: float) -> void:
	if not ray.enabled: return
	if ray.is_colliding():
		var power = Master.power * Laser.power
		var c: Object = ray.get_collider()
		var burn_point = to_local(ray.get_collision_point())
		if c is LaserCounter:
			burn_point += c.counter(power) * delta * Vector2.UP
		else:
			c.hitten(power)
		counter.shift2(burn_point)
		Laser.shift2(burn_point)
	else:
		counter.shift2(ray.cast_to)
		Laser.shift2(ray.cast_to)


func shoot() -> void:
	ray.enabled = true
	counter.collision.disabled = false
	Laser.fire(ray.cast_to)


func cease() -> void:
	ray.enabled = false
	counter.collision.disabled = true
	Laser.cease()
	
	
func ash() -> void:
	cease()


func is_shooting() -> bool:
	return ray.enabled
	
	
func shift(rot: float, move: Vector2 = Vector2.ZERO) -> void:
	position += move
	rotation += rot











