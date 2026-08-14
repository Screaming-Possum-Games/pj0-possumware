extends Control

var menu_scene = load("res://scenes/menus/main_menu.tscn")


func _on_main_volume_slider_value_changed(value):
    AudioManager.set_bus_volume("Master", value)


func _on_bgm_volume_slider_value_changed(value):
    AudioManager.set_bus_volume("BGM", value)


func _on_sfx_volume_slider_value_changed(value):
    AudioManager.set_bus_volume("SFX", value)


func _on_main_menu_button_pressed():
    if not menu_scene.can_instantiate():
        print_debug(menu_scene)
    get_tree().change_scene_to_packed(menu_scene)
    queue_free()
