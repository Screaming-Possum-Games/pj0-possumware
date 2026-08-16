extends Microgame


@export var enemy_marker: Array[Marker2D] = []
@export var player_marker: Array[Marker2D] = []
@export var inventory_marker: Array[Marker2D] = []


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
    var image: Image = Image.load_from_file("res://assets/battle_merge/PNG/Black/Slab (outline)/runeBlack_slabOutline_%0*d.png" % [3,n])
    var texture: ImageTexture = ImageTexture.create_from_image(image)
    var enemy: Rune = load("res://scenes/levels/microgames/battle_merge/rune.tscn").instantiate()
    enemy.setup_rune(texture, marker.global_position, "EnemyRunes")
    # adding data
    #enemy_runes.append(enemy)
    enemy_runes_container.add_child(enemy)


func spawn_player_runes(marker: Marker2D) -> void:
    var image: Image = Image.load_from_file("res://assets/battle_merge/PNG/Blue/Slab (outline)/runeBlue_slabOutline_001.png")
    var texture: ImageTexture = ImageTexture.create_from_image(image)
    var player_rune: Rune = load("res://scenes/levels/microgames/battle_merge/rune.tscn").instantiate()
    player_rune.setup_rune(texture, marker.global_position, "PlayerRunes")
    # adding data
    #player_runes.append(player_rune)
    player_runes_container.add_child(player_rune)
    var new_drop_zone = DropZone.new()
    player_rune.add_child(new_drop_zone)
    new_drop_zone.drop_behavior = DropBehaviorReplace.new()
    new_drop_zone.accepted_draggable_types = inventory_runes



# gameplay loop
## 10 seconds to drag inventory runes onto spawned runes
## drag to make stronger
## once 10 seconds ends, both sides fight and bigger number wins!
## loss condition: if enemy runes > your runes
## win condition: just drag better /shrug
func spawn_random_inventory(marker: Marker2D) -> void:
    var n := randi_range(1, 36)
    var image: Image = Image.load_from_file("res://assets/battle_merge/PNG/Blue/Slab (outline)/runeBlue_slabOutline_%0*d.png" % [3,n])
    var texture: ImageTexture = ImageTexture.create_from_image(image)
    var inventory_rune: Rune = load("res://scenes/levels/microgames/battle_merge/rune.tscn").instantiate()
    inventory_rune.setup_rune(texture, marker.global_position, "InventoryRunes")
    # adding data
    inventory_runes.append(inventory_rune)
    inventory_runes_container.add_child(inventory_rune)
    var new_draggable = Draggable.new()
    inventory_rune.add_child(new_draggable)


# rune data
## name
## atk points



# inventory data
## holds 3 runes at all times
## after dragging and dropping a rune from the inventory, replace it (might not have time)


# board data
## 3 player runes with stats
## 3 enemy runes with stats
## W/L checks?
