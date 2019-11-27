extends "res://script/char/char_abs.gd"

#var high_speed: int = 300
#var low_speed: int = 100

var arena: Arena
var t: float = 30
var l: float = 20
var b: float = 30
var r: float = 20

var timer := Timer.new()

var stata: StatABS
var stati: int = 0
var stats: Array = []
var sync_force: Array = []
var sync_force_choose: int = -1
var syncs: Array = []

var shooting: bool = false


func armed(s1: StatABS, s2: StatABS) -> void:
	stats.append(s1)
	stats.append(s2)
	s1.armed(self)
	s2.armed(self)
	stata = stats[stati]
	stata.enable()


func _enter_tree() -> void:
	arena = get_parent().ScnArena
	t += arena.t
	l += arena.l
	b = arena.b - b
	r = arena.r - r
	
	timer.one_shot = true
	add_child(timer)


func _physics_process_override(delta: float) -> void:
	._physics_process_override(delta)
	position.x = clamp(position.x, l, r)
	position.y = clamp(position.y, t, b)
	
	
# warning-ignore:unused_argument
func _process(delta: float) -> void:
	# anime: movement anime
	movement = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		movement.x += 1.0
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1.0
	if Input.is_action_pressed("ui_down"):
		movement.y += 1.0
		
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("stg_shoot"):
		stata.shoot()
		shooting = true
#		for sc in stata.scs:
#			sc.shoot()
	elif event.is_action_released("stg_shoot"):
		stata.cease()
		shooting = false
#		for sc in stata.scs:
#			sc.cease()
	if event.is_action_pressed("stg_bomb"):
		print("sync")
		if not syncs.empty(): syncs.pop_front().trigger()
	if event.is_action_pressed("stg_savelife"):
		if sync_force.empty():
			juesi()
		else:
			savelife()
	elif event.is_action_released("stg_savelife"):
		if sync_force_choose > -1:
			sync_force[sync_force_choose].trigger()
		sync_force.clear()
		sync_force_choose = -1
#	if event.is_action_released("stg_slow"):
#		speed = high_speed
#		sc_active = sc_high
#		if sc_low[0].is_shooting():
#			for sc in sc_low:
#				sc.cease()
#			for sc in sc_high:
#				sc.shoot()
#		$Hurtbox/Sprite.visible = false
		# Plyaer Switch High Anime Play
		# Plyaer Switch High Sound Play
	if event.is_action_pressed("stg_slow"):
		stata.cease()
		stata.disable()
		stati = (stati + 1) % 2
		stata = stats[stati]
		stata.enable()
		if shooting: stata.shoot()
#		speed = low_speed
#		sc_active = sc_low
#		if sc_high[0].is_shooting():
#			for sc in sc_low:
#				sc.shoot()
#			for sc in sc_high:
#				sc.cease()
#		$Hurtbox/Sprite.visible = true
		# Plyaer Switch Low Anime Play
		# Plyaer Switch Low Sound Play
		
		
func juesi() -> void:
	print("juesi")
	
	
func savelife() -> void:
	print("savelife")
	
	
func _on_sync_for_death(sd) -> void:
	syncs.clear()
	syncs.append(sd)


func explosion() -> void:
	var ev = InputEventAction.new()
	ev.action = "stg_slow"
	ev.pressed = false
	Input.parse_input_event(ev)
	ev.action = "stg_shoot"
	ev.pressed = false
	Input.parse_input_event(ev)
	
	set_process_unhandled_input(false)
	set_process(false)
	set_physics_process(false)
	modulate = Color(1, 0, 0, .5)
	# Plyaer Died Anime Play
	
	
func reborn() -> void:
	shooting = false
	.reborn()
	set_process_unhandled_input(true)
	set_process(true)
	set_physics_process(true)
	modulate = Color(1, 1, 1, 1)
	
	def = 1
	timer.start(3)
	yield(timer, "timeout")
	def = init_def
	
	
	
	
	
	
	
	
	
