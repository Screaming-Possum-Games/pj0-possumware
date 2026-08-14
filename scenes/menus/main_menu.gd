extends Control

const MENU_THEME: AudioStream = preload("res://assets/sound/Sketchbook 2024-02-28_01.ogg")
var settings_scene: PackedScene = preload("res://scenes/menus/settings.tscn")


func _ready():
    AudioManager.request_track(MENU_THEME)


func _on_play_button_pressed():
    var game_scene: PackedScene = preload("res://scenes/levels/game.tscn")
    get_tree().change_scene_to_packed(game_scene)
    queue_free()


func _on_settings_button_pressed():
    if not settings_scene.can_instantiate():
        print_debug(settings_scene)
    get_tree().change_scene_to_packed(settings_scene)
    queue_free()
