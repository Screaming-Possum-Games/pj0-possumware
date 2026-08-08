extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_win_pressed():
    _on_level_won()


func _on_lose_pressed():
    _on_level_lost()
