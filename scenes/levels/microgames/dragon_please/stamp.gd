extends Area2D

@export var sprite_node: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
    _create_collision_polygon(sprite_node)


func _create_collision_polygon(sprite: Sprite2D):
    """
    Stolen and updated from here: https://github.com/mellowminx/demo-2023/blob/main/project/autopolygonsprite.gd
    """
    var bm = BitMap.new()
    bm.create_from_image_alpha(sprite.texture.get_image())
    var rect = Rect2(0, 0, sprite.texture.get_width(), sprite.texture.get_height())
    var my_array = bm.opaque_to_polygons(rect, 2)
    var my_polygon = Polygon2D.new()
    my_polygon.set_polygons(my_array)
    var offsetX = 0
    var offsetY = 0
    if (sprite.texture.get_width() % 2 != 0):
        offsetX = 1
    if (sprite.texture.get_height() % 2 != 0):
        offsetY = 1
    for i in range(my_polygon.polygons.size()):
        var my_collision = CollisionPolygon2D.new()
        my_collision.set_polygon(my_polygon.polygons[i])
        my_collision.position -= Vector2(
            (sprite.texture.get_width() / 2) + offsetX, (sprite.texture.get_height() / 2) + offsetY
        ) * scale.x
        my_collision.scale = scale
        add_child(my_collision)
