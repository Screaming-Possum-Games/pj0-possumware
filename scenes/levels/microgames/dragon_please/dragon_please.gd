extends Microgame

enum PaperStampState {
    UNSTAMPED,
    APPROVED,
    DENIED,
}

var held_object = null
var paper_state: Dictionary[String, PaperStampState] = {}
var target_paper_state: Dictionary[String, PaperStampState] = {}
var rules_text: String = """[font size=32]RULES:
[ul]
[color=red]Red: {0}[/color]
[color=blue]Blue: {1}[/color]
[color=green]Green: {2}[/color]
[/ul][/font]
"""


func _ready():
    super._ready()
    timer.timeout.connect(func(): print("Timer finished!"))
    %ApproveZone.stamped.connect(func(paper: String): stamp_paper(paper, PaperStampState.APPROVED))
    %DenyZone.stamped.connect(func(paper: String): stamp_paper(paper, PaperStampState.DENIED))
    for node in get_tree().get_nodes_in_group("pickable"):
        node.clicked.connect(_on_pickable_clicked)
        stamp_paper(node.name, PaperStampState.UNSTAMPED)
        set_target_state(node.name)

    %RulesText.text = rules_text.format([
        "APPROVE" if target_paper_state["Red Paper"] == PaperStampState.APPROVED else "DENY",
        "APPROVE" if target_paper_state["Blue Paper"] == PaperStampState.APPROVED else "DENY",
        "APPROVE" if target_paper_state["Green Paper"] == PaperStampState.APPROVED else "DENY",
    ])


func _process(_delta):
    var is_win = true

    for paper in paper_state.keys():
        if not paper_state[paper] == target_paper_state[paper]:
            is_win = false

    if is_win:
        level_won.emit()


func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if held_object and !event.pressed:
            held_object.drop(Input.get_last_mouse_velocity())
            held_object = null


func stamp_paper(paper_name: String, stamp_state: PaperStampState):
    paper_state[paper_name] = stamp_state


func set_target_state(paper_name: String):
    target_paper_state[paper_name] = [PaperStampState.APPROVED, PaperStampState.DENIED].pick_random()


func _on_pickable_clicked(object):
    if !held_object:
        object.pickup()
        held_object = object
