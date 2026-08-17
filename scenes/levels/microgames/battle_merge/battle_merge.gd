extends Microgame


@export var enemy_marker: Array[Marker2D] = []
@export var player_marker: Array[Marker2D] = []
@export var inventory_marker: Array[Marker2D] = []


# I am not sure if I really need these arrays, but they're here 😀
@onready var enemy_runes_container: Node2D = $GameBoard/EnemyRunes
var enemy_runes: Array[Area2D] = []

@onready var player_runes_container: Node2D = $GameBoard/PlayerRunes
var player_runes: Array[Area2D] = []

@onready var inventory_runes_container: Node2D = $Inventory/InventoryRunes
var inventory_runes: Array[Area2D] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for marker in enemy_marker:
        spawn_random_enemy(marker)

    for marker in player_marker:
        spawn_player_runes(marker)

    for marker in inventory_marker:
        spawn_random_inventory(marker)


# on game start
## spawn 3 enemy runes
### get ref and place @ markers 4/5/6
## spawn 3 own runes
### get ref and place @ markers 1/2/3
### doobly two
## spawn inventory of 3 runes
func spawn_random_enemy(marker: Marker2D) -> void:
    var n := randi_range(1, 36)

    var calculated_attack = n + randi_range(1, 5)

    var img_texture_path := "res://assets/battle_merge/PNG/Black/Slab (outline)/runeBlack_slabOutline_%0*d.png" % [3,n]
    var img_texture: Texture2D = load(img_texture_path)
    var enemy: Rune = load("res://scenes/levels/microgames/battle_merge/rune.tscn").instantiate()

    enemy.setup_rune(img_texture, marker.global_position, "EnemyRunes", calculated_attack)
    # adding data
    enemy_runes.append(enemy)
    enemy_runes_container.add_child(enemy)


func spawn_player_runes(marker: Marker2D) -> void:
    var starting_attack = 5
    var img_texture_path := "res://assets/battle_merge/PNG/Blue/Slab (outline)/runeBlue_slabOutline_001.png"
    var img_texture: Texture2D = load(img_texture_path)
    var player_rune: Rune = load("res://scenes/levels/microgames/battle_merge/rune.tscn").instantiate()

    player_rune.setup_rune(img_texture, marker.global_position, "PlayerRunes", starting_attack)
    player_runes.append(player_rune)
    player_runes_container.add_child(player_rune)

    #var new_drop_zone := DropZone.new()
    #player_rune.add_child(new_drop_zone)

    #new_drop_zone.drop_behavior = DropBehavior.new()
    # since there is no valid "snap" space due to the collision shape being the exact size of Rune
    # disabling snap prevents Draggable from looking for an empty space and rejecting.
    #new_drop_zone.snap_style = DropZone.SNAP_STYLE.NO_SNAP
    # creating the type that the drop zone will accept via ID
    #var t := DraggableType.new()
    #t.id = "InventoryRune"
    #new_drop_zone.accepted_draggable_types = [t]


# gameplay loop
## 10 seconds to drag inventory runes onto spawned runes
## drag to make stronger
## once 10 seconds ends, both sides fight and bigger number wins!
## loss condition: if enemy runes > your runes
## win condition: just drag better /shrug
func spawn_random_inventory(marker: Marker2D) -> void:
    var n := randi_range(1, 36)
    var inventory_attack = n * 2
    var img_texture_path := "res://assets/battle_merge/PNG/Blue/Slab (outline)/runeBlue_slabOutline_%0*d.png" % [3,n]
    var img_texture: Texture2D = load(img_texture_path)
    var inventory_rune: Rune = load("res://scenes/levels/microgames/battle_merge/rune.tscn").instantiate()

    inventory_rune.setup_rune(img_texture, marker.global_position, "InventoryRunes", inventory_attack)
    inventory_runes.append(inventory_rune)
    inventory_runes_container.add_child(inventory_rune)

    #var new_draggable := Draggable.new()
    #inventory_rune.add_child(new_draggable)
    # gave the draggable a targetable ID for drop zone
    #new_draggable.type.id = "InventoryRune"


func remove_inventory_rune_from_array(rune_node: Rune) -> void:
    if rune_node in inventory_runes:
        inventory_runes.erase(rune_node)


func did_i_win() -> void:
    var score := 0
    var enemy_score := 0

    for rune in player_runes:
        if is_instance_valid(rune):
            score += rune.attack_points

    for rune in enemy_runes:
        if is_instance_valid(rune):
            enemy_score += rune.attack_points

    if score >= enemy_score:
        print("Win!")
    else:
        print("Lose...")
