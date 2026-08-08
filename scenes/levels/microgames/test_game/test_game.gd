extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready():
    super._ready()


func _on_win_pressed():
    _on_level_won()


func _on_lose_pressed():
    _on_level_lost()
