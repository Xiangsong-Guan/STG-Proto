extends Node2D

class_name LaserABS

signal laser_counter
signal laser_hit

var burn_txr: Resource
var laser_txr: Resource
var wide: int = 10

var power: int = 1

onready var head: Sprite = $HeadSprite
onready var laser: Sprite = $LaserSprite
onready var tail: Sprite = $TailSprite


func _init() -> void:
	visible = false
	
	
func _ready() -> void:
	laser.visible = false
	head.visible = false
	tail.visible = false


func fire(h_pos: Vector2) -> void:
	shift2(h_pos)
	laser.visible = true
	head.visible = true
	
	
func shift2(h_pos: Vector2) -> void:
	head.position = h_pos
	laser.scale.y = h_pos.length() / 2
	laser.position = h_pos / 2
	
	
func cease() -> void:
	laser.visible = false
	head.visible = false
	
	
func standby() -> void:
	visible = true
	tail.visible = true
	
	
func unstandby() -> void:
	tail.visible = false
	visible = false

















