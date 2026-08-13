extends Control

const MENU_THEME: AudioStream = preload("res://assets/sound/Sketchbook 2024-02-28_01.ogg")


func _ready():
    AudioManager.request_track(MENU_THEME)


func _on_play_button_pressed():
    var game_scene: PackedScene = preload("res://scenes/levels/game.tscn")
    get_tree().change_scene_to_packed(game_scene)
