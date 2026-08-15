extends Area2D

@export var target_path: NodePath
var target: Node
var won := false

func _ready() -> void:
    target = get_node_or_null(target_path)
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if won: 
        return
    if body == target:
        won = true
        # trigger your win here
        print("WIN: target hit the floor")
