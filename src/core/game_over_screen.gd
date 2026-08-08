extends Node

@onready var score_label: Label = %ScoreLabel
var score: int = 0


func _ready():
    score_label.text = "You completed {0} games before you bricked it!".format([score])


func set_score(_score: int):
    score = _score
