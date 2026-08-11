extends Node

@export var game_over: PackedScene
@export var microgames: Dictionary[String, PackedScene]

@onready var current_game: Node = %CurrentGame
@onready var pause_menu: Node = %PauseMenu
var recent_microgames: Array[String] = []

var games_won: int = 0
var games_lost: int = 0
var lives: int = 5


func _ready() -> void:
    %PauseMenu.hide()
    load_microgame(pick_next())


func _process(_delta):
    %LivesRemaining.text = "Lives: %d" % lives
    var game = %CurrentGame.get_child(0) as Microgame
    %TimerText.text = "Time: %3.2f" % game.get_timer().time_left


func pick_next():
    recent_microgames.append(current_game.name)
    var valid_games: Array[String] = microgames.keys().filter(func (x): return x not in recent_microgames)
    
    if len(valid_games) <= 1:
        recent_microgames.pop_front()
        recent_microgames = recent_microgames.filter(func (_x): return randf() <= 0.5)
        valid_games = microgames.keys().filter(func (x): return x not in recent_microgames)
    
    return valid_games.pick_random()


func load_microgame(game_name: String, time_multi: float = 1.0):
    if current_game.get_child_count() > 0:
        unload_microgames()

    var game = microgames[game_name].instantiate() as Microgame
    game.time_multi = time_multi

    game.level_won.connect(func():
        games_won += 1
        unload_microgames()
        load_microgame(pick_next())
    )

    game.level_lost.connect(func():
        games_lost += 1
        lives -= 1
        unload_microgames()
        load_microgame(pick_next())
    )

    game.request_ready()
    current_game.add_child(game)

    if not game.is_node_ready():
        await game.ready


func on_game_over():
    unload_microgames()
    var go_scene = game_over.instantiate()
    go_scene.set_score(games_won)
    add_sibling(go_scene)
    queue_free()


func unload_microgames():
    for child in current_game.get_children():
        child.queue_free()


func pause_microgame():
    pause_menu.show()
    get_tree().paused = true


func unpause_microgame():
    pause_menu.hide()
    get_tree().paused = false
