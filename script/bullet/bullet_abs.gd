extends KinematicBody2D

class_name BulletABS

signal bullet_hit
signal bullet_ash
signal bullet_bye

onready var cshape: CollisionShape2D = $CollisionShape2D
onready var anime: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite
onready var init_modu: Color = $Sprite.modulate

var base_damage: int = 1
var damage: int

var movement: Vector2 = Vector2.UP
var speed: int = 0

var Away := VisibilityNotifier2D.new()


func _init() -> void:
# warning-ignore:return_value_discarded
	connect("bullet_hit", self, "_on_hit_anime")
# warning-ignore:return_value_discarded
	connect("bullet_ash", self, "_on_ash_anime")
# warning-ignore:return_value_discarded
	connect("tree_exited", self, "_on_engage")
	add_child(Away)
# warning-ignore:return_value_discarded
	Away.connect("screen_exited", self, "_on_disappear")


func _physics_process(delta: float) -> void:
	var c := move_and_collide(delta * movement * speed)
	if c:
		cshape.set_deferred("disabled", true)
		if c.collider.hitten(damage):
			emit_signal("bullet_hit")
		else:
			emit_signal("bullet_ash")
		
		
func _on_hit_anime() -> void:
	speed = 0
	anime.play("hit")
	yield(anime, "animation_finished")
	emit_signal("bullet_bye")
		
		
func _on_ash_anime() -> void:
	anime.play("ash")
	yield(anime, "animation_finished")
	emit_signal("bullet_bye")


func _on_engage() -> void:
	cshape.disabled = false
	sprite.modulate = init_modu


func start(pos: Vector2, rot: float, spd: int, muti_p: int) -> void:
	var dir := rot - movement.angle() - PI/2
	rotate(dir)
	position = pos
	movement= movement.rotated(dir)
	speed = spd
	damage = muti_p * base_damage


# This func called when bullet is out of Arena
func _on_disappear() -> void:
	if anime.is_playing():
		anime.stop()
		anime.emit_signal("animation_finished")
	else:
		emit_signal("bullet_bye")


# This func called when some char died, his/her bullet should
# fade away from scn; Sometimes bullet will be countered, that
# means bullet should also fade away.
func ash() -> void:
	cshape.set_deferred("disabled", true)
	_on_ash_anime()
