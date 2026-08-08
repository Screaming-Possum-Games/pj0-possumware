extends Area2D

@onready var draggable_node: Draggable = $Draggable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_draggable_drag_ended(area: Area2D, drop_spot: SnappingSpot) -> void:
    pass
