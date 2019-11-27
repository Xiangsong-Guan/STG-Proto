extends Node2D

class_name ShootComp

enum {USEBLE, DEFERR, ALIVE}

var BulletRes: Resource
var ShootingInterval: Timer

var Scn: Node2D
var Master: CharABS
var Target: Node2D

var muti_ang: Array
var muti_off: Array
var shoot_interval: float
var bullet_speed: int
var snipe: bool

# bullet pool
var bullet_pool: Array = []
var bullet_pool_useble: Array = []
var bullet_pool_size: int
var bullet_pool_pro: int = 0

func new_bullet(index: int) -> BulletABS:
	var b = BulletRes.instance()
	b.connect("bullet_bye", self, "ret_bullet", [index])
	b.connect("tree_exited", self, "useble_bullet", [index])
	return b

func get_bullet() -> BulletABS:
	var index: int = -1
	for i in range(bullet_pool_pro, bullet_pool_size):
		if bullet_pool_useble[i] == USEBLE:
			index = i
			break
	if index == -1:
		bullet_pool_pro = 0
		for i in range(bullet_pool_pro, bullet_pool_size):
			if bullet_pool_useble[i] == USEBLE:
				index = i
				break
	if index != -1:
		bullet_pool_pro = (index + 1) % bullet_pool_size
		bullet_pool_useble[index] = ALIVE
	else:
		print("New bullet in!")
		bullet_pool.append(new_bullet(bullet_pool_size))
		bullet_pool_useble.append(ALIVE)
		bullet_pool_size += 1
	Scn.bn += 1 # TEST
	return bullet_pool[index]

func ret_bullet(index: int) -> void:
	if bullet_pool_useble[index] == ALIVE:
		bullet_pool_useble[index] = DEFERR
		Scn.call_deferred("remove_child", bullet_pool[index])
		
func useble_bullet(index: int) -> void:
	bullet_pool_useble[index] = USEBLE
	Scn.bn -= 1 # TEST

# func swp_bullet(index: int) -> void:
# 	bullet_pool[index].queue_free()
# 	bullet_pool[index] = new_bullet(index)
# 	bullet_pool_useble[index] = true
# bullet pool end


func _init(bullet_num: int, bullet_res: Resource, s_pos: Position2D, shoot_args: Dictionary = {}) -> void:
	BulletRes = bullet_res
	position = s_pos.position
	rotation = s_pos.rotation
	muti_ang = shoot_args.get("angles", [.0])
	muti_off = shoot_args.get("offsets", [Vector2(.0, .0)])
	shoot_interval = shoot_args.get("interval", .1)
	bullet_speed = shoot_args.get("speed", 1000)
	snipe = shoot_args.get("snipe", false)

	bullet_pool_size = bullet_num
	bullet_pool.resize(bullet_num)
	bullet_pool_useble.resize(bullet_num)
	for i in range(bullet_pool_size):
		bullet_pool[i] = new_bullet(i)
		bullet_pool_useble[i] = USEBLE
	
	ShootingInterval = Timer.new()
	ShootingInterval.set_wait_time(shoot_interval)
# warning-ignore:return_value_discarded
	ShootingInterval.connect("timeout", self, "_on_ShootingInterval_timeout")


func _enter_tree() -> void:
	Master = get_parent()
	Scn = Master.get_parent()
	add_child(ShootingInterval)


func shoot(target: Node2D = null, once: bool = false) -> void:
	Target = target
	_on_ShootingInterval_timeout()
	if not once: ShootingInterval.start()


func cease() -> void:
	ShootingInterval.stop()
	
	
func formation() -> void:
	pass
	# show the fire point
	
	
func unformation() -> void:
	pass
	# unshow the fire point
	
	
func ash() -> void:
	cease()
	for i in range(0, bullet_pool_size):
		if bullet_pool_useble[i] == ALIVE:
			bullet_pool[i].ash()


func _on_ShootingInterval_timeout():
	var gps = position + Master.position
	if snipe:
		rotation = (Target.position - gps).angle() + PI/2
	for offset in muti_off:
		for angle in muti_ang:
			var bullet: BulletABS = get_bullet()
			bullet.start(gps + offset, rotation + angle, bullet_speed, Master.power)
			Scn.add_child(bullet)
	

func is_shooting() -> bool:
	return not ShootingInterval.is_stopped()
	
	
func shift(rot: float, move: Vector2 = Vector2.ZERO) -> void:
	rotation += rot
	position += move












