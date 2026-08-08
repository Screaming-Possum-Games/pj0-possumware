class_name Microgame extends Node

var timer: Timer
@export var level_len: float = 10.0

signal level_won
signal level_lost


func _ready():
    timer = Timer.new()
    timer.wait_time = level_len
    timer.timeout.connect(_on_level_lost)
    add_child(timer)
    timer.start()


func _on_level_lost():
    timer.stop()
    level_lost.emit()


func _on_level_won():
    timer.stop()
    level_won.emit()
