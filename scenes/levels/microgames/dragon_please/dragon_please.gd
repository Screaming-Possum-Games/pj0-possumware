extends Microgame

enum PaperStampState {
    UNSTAMPED,
    APPROVED,
    DENIED,
}

var held_object = null
var paper_state: Dictionary[String, PaperStampState] = {}


func _ready():
    super._ready()
    timer.timeout.connect(func(): print("Timer finished!"))
    for node in get_tree().get_nodes_in_group("pickable"):
        node.clicked.connect(_on_pickable_clicked)
        stamp_paper(node.name, PaperStampState.UNSTAMPED)


func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if held_object and !event.pressed:
            held_object.drop(Input.get_last_mouse_velocity())
            held_object = null


func stamp_paper(paper_name: String, stamp_state: PaperStampState):
    paper_state[paper_name] = stamp_state


func _on_pickable_clicked(object):
    if !held_object:
        object.pickup()
        held_object = object
