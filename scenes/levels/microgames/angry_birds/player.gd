extends Area2D

@export var launch_speed: float = 600.0
var velocity: Vector2 = Vector2.ZERO

@onready var draggable_node = $Draggable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if velocity != Vector2.ZERO:
        position += velocity * delta
        velocity = velocity.move_toward(Vector2.ZERO, 300.0 * delta)
        
        if velocity == Vector2.ZERO and draggable_node:
            draggable_node.process_mode = PROCESS_MODE_INHERIT


func _on_draggable_drag_ended(area: Area2D, drop_spot: SnappingSpot) -> void:
    if draggable_node:
        draggable_node.process_mode = PROCESS_MODE_DISABLED
    var forward_direction: Vector2 = Vector2.RIGHT.rotated(rotation)
    velocity = forward_direction * launch_speed
