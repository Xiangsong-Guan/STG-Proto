extends Area2D

class_name Arena

#var Top: CollisionShape2D
#var Bottom: CollisionShape2D
#var Left: CollisionShape2D
#var Right: CollisionShape2D

var l: float
var r: float
var t: float
var b: float
var h: float
var w: float
# var offset: float = 30
var total_size: Vector2


func _enter_tree() -> void:
	total_size = get_viewport_rect().size
	h = total_size.y
	w = 5 * total_size.x / 10
	l = 2 * total_size.x / 10
	t = 0
	r = l + w
	b = t + h
	
#	Top = CollisionShape2D.new()
#	Top.shape = RectangleShape2D.new()
#	Top.shape.extents = Vector2(total_size.x / 2, offset) 
#	Top.position = Vector2(l + (w / 2), t - (2 * offset))
#	Bottom= CollisionShape2D.new()
#	Bottom.shape = RectangleShape2D.new()
#	Bottom.shape.extents = Vector2(total_size.x / 2, offset) 
#	Bottom.position = Vector2(l + (w / 2), b + (2 * offset))
#	Left = CollisionShape2D.new()
#	Left.shape = RectangleShape2D.new()
#	Left.shape.extents = Vector2(offset, h / 2) 
#	Left.position = Vector2(l - (2 * offset), h / 2)
#	Right= CollisionShape2D.new()
#	Right.shape = RectangleShape2D.new()
#	Right.shape.extents = Vector2(offset, h / 2) 
#	Right.position = Vector2(r + (2 * offset), h / 2)
#
#	add_child(Top)
#	add_child(Bottom)
#	add_child(Left)
#	add_child(Right)
#
#	# 2^10 = 1024, means "Arena"
#	collision_layer = 1024
#	# 5 means PB, 6 means EB, 7 means Item
#	collision_mask = pow(2, 5) + pow(2, 6) + pow(2, 7)
#
#	connect("body_exited", self, "_on_something_disappear")


#func _on_something_disappear(d: PhysicsBody2D) -> void:
##	d.disappear()
#	print("nothing")


func transform_to_global(x: float, y: float) -> Vector2:
	return Vector2(x + l, y + t)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
