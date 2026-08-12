extends Area2D

@export var max_launch_speed: float = 1200.0
@export var slingshot_sensitivity: float = 5.0 
@export var friction: float = 400.0
@export var push_force: float = 100.0

var velocity: Vector2 = Vector2.ZERO
var drag_start_position: Vector2 = Vector2.ZERO
var is_aiming: bool = false

@onready var draggable_node: Node = $Draggable

func _ready() -> void:
    if draggable_node.has_signal("drag_started"):
        draggable_node.connect("drag_started", _on_draggable_drag_started)
    body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
    if is_aiming:
        queue_redraw()
        
    if velocity != Vector2.ZERO:
        position += velocity * delta
        velocity = velocity.move_toward(Vector2.ZERO, friction * delta)


func _on_draggable_drag_started(area: Area2D) -> void:
    drag_start_position = global_position
    is_aiming = true


func _on_draggable_drag_ended(area: Area2D, drop_spot: SnappingSpot) -> void:
    is_aiming = false
    queue_redraw()
    
    if draggable_node:
        draggable_node.process_mode = PROCESS_MODE_DISABLED
    
    var pull_vector: Vector2 = drag_start_position - global_position
    
    var launch_force: Vector2 = pull_vector * slingshot_sensitivity
    velocity = launch_force.limit_length(max_launch_speed)


func _on_body_entered(body: Node2D) -> void:
    if body is RigidBody2D:
        if not body.is_in_group("blocks"):
            body.add_to_group("blocks")
        
        var push_direction = (body.global_position - global_position).normalized()
        
        if velocity.length() > 0:
            push_direction = velocity.normalized()
        
        body.apply_impulse(push_direction * push_force * 0.35)
        body.linear_damp = 1.0
        body.contact_monitor = true
        body.gravity_scale = 1.0
        
        for b in get_tree().get_nodes_in_group("blocks"):
            if b is RigidBody2D:
                b.gravity_scale = 1.0
                b.sleeping = false # helps make sure they start moving immediately
