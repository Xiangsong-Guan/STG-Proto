extends Node2D

signal dead

const PlayerRes = preload("res://Player.tscn")
const BossTestRes = preload("res://char/TestEnemy.tscn")
const ArenaRes = preload("res://script/arena.gd")

const StatNormal = preload("res://script/stats/normal.gd")
const StatLowSpd = preload("res://script/stats/low_spd.gd")

var ScnArena: Arena
onready var GUI: Control = $GUILayer/GUI

var boss: CharABS
var player: CharABS

var bn: int = 0


func _enter_tree() -> void:
	ScnArena = ArenaRes.new()
	add_child(ScnArena)

	boss = BossTestRes.instance()
	player = PlayerRes.instance()
	
	player.position = ScnArena.transform_to_global(ScnArena.w/2, 9*ScnArena.h/10)
	add_child(player)
	
	boss.position = ScnArena.transform_to_global(ScnArena.w/2, -1*ScnArena.h/10)
	add_child(boss)

# warning-ignore:return_value_discarded
	player.connect("char_died", self, "_on_player_died")
	
	player.armed(StatNormal.new(), StatLowSpd.new())


func _ready() -> void:
# warning-ignore:return_value_discarded
	boss.connect("hp_changed", GUI, "_on_boss_hp_changed")
	boss.start(player)


func restart() -> void:
	boss.reborn()
	player.reborn()
	boss.position = ScnArena.transform_to_global(ScnArena.w/2, -1*ScnArena.h/10)
	boss.start(player)
	
	
func _on_player_died() -> void:
	if is_instance_valid(boss):
		boss.cease()
	emit_signal("dead")
