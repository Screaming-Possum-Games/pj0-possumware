extends Control

@export var initial_scene: PackedScene = preload("res://scenes/levels/level_0.tscn")
var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    tween = create_tween()
    tween.set_parallel(false)
    tween.tween_property(
        %SPLogo,
        "modulate:a",
        1,
        2.0
    ).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(
        %SPLogo,
        "modulate:a",
        1,
        2.0
    )
    
    tween.finished.connect(func ():
        get_tree().root.add_child(initial_scene.instantiate())
        queue_free()
    )

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed and event.keycode in [
            KEY_ESCAPE, KEY_SPACE
        ]:
            tween.pause()
            get_tree().root.add_child(initial_scene.instantiate())
            queue_free()
