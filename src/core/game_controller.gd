extends Node

@export var game_over: PackedScene
@export var microgames: Dictionary[String, PackedScene]

@onready var current_game: Node = %CurrentGame
@onready var pause_menu: Node = %PauseMenu
var recent_microgames: Array[String] = []

var games_won: int = 0
var games_lost: int = 0
var lives: int = 5

func load_microgame(game_name: String):
    if current_game.get_child_count() > 0:
        unload_microgame()

    var game = microgames[game_name].instantiate() as Microgame

    game.level_won.connect(func():
        games_won += 1
        unload_microgame()
    )

    game.level_lost.connect(func():
        games_lost += 1
        lives -= 1
        unload_microgame()
    )
    current_game.add_child(game)


func on_game_over():
    unload_microgame()
    var go_scene = game_over.instantiate()
    # Need to make the game over scene have points and
    # set those here.
    add_sibling(go_scene)
    queue_free()


func unload_microgame():
    current_game.get_child(0).queue_free()


func pause_microgame():
    pause_menu.show()
    get_tree().paused = true


func unpause_microgame():
    pause_menu.hide()
    get_tree().paused = false
