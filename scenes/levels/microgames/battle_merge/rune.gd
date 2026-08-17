class_name Rune extends Area2D


# texture/pic
# do i need data here...
# interactions/detections
# onbodyentered check for le drag -> LET IT GOOOO


# rune data
## name
## atk points
@export var attack_points: int = 5

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var starting_position: Vector2 = Vector2.ZERO


func setup_rune(texture: Texture2D, target_position: Vector2, group_name: String, setup_attack_points: int):
    attack_points = setup_attack_points

    $Sprite2D.texture = texture
    $Label.text = str(setup_attack_points)
    position = target_position
    add_to_group(group_name)
    starting_position = target_position


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
    if not is_in_group("InventoryRunes"):
        return

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            is_dragging = true
            drag_offset = global_position - get_global_mouse_position()
            z_index = 10


func _input(event: InputEvent) -> void:
    if is_dragging:
        if event is InputEventMouseMotion:
            global_position = get_global_mouse_position() + drag_offset
        elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
            is_dragging = false
            z_index = 0
            _check_for_drop_merge()


func _check_for_drop_merge() -> void:
    var overlapping_areas = get_overlapping_areas()
    var merged_successfully := false

    for area in overlapping_areas:
        if area.is_in_group("PlayerRunes") and area is Rune:
            area.attack_points += self.attack_points
            area.get_node("Label").text = str(area.attack_points)
            merged_successfully = true
            break
        else:
            return

    if merged_successfully:
        var manager = get_tree().current_scene
        if manager.has_method("remove_inventory_rune_from_array"):
            manager.remove_inventory_rune_from_array(self)
        queue_free()
    else:
        var tween = create_tween()
        tween.tween_property(self, "global_position", starting_position, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
