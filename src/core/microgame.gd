class_name Microgame extends Node

var timer: Timer
@export var level_len: float = 10.0
var time_multi: float = 1.0

signal level_won
signal level_lost


func _ready():
    print("Ding!")
    timer = Timer.new()
    timer.wait_time = level_len * time_multi
    timer.timeout.connect(_on_level_lost)
    add_child(timer)
    timer.start()


func _on_level_lost():
    timer.paused = true
    level_lost.emit()


func _on_level_won():
    timer.paused = true
    level_won.emit()
