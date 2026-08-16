class_name Rune extends Area2D


# texture/pic
# do i need data here...
# interactions/detections
# onbodyentered check for le drag -> LET IT GOOOO


#func _ready() -> void:
    #if is_draggable:
        #var new_draggable = Draggable.new()
        #add_child(new_draggable)
    #else:
        #return



func setup_rune(texture: Texture2D, target_position: Vector2, group_name: String):
    $Sprite2D.texture = texture
    position = target_position
    add_to_group(group_name)
