extends Control


func _on_play_button_pressed():
    var game_scene: PackedScene = preload("res://scenes/levels/game.tscn")
    get_tree().change_scene_to_packed(game_scene)
