extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass

# on game start
## spawn 3 enemy runes
### get ref and place @ markers 4/5/6
## spawn 3 own runes
### get ref and place @ markers 1/2/3
### doobly two
## spawn inventory of 3 runes


# gameplay loop
## 10 seconds to drag inventory runes onto spawned runes
## drag matching to make stronger
## once 10 seconds ends, both sides fight and bigger number wins!
## loss condition: if enemy runes > your runes
## win condition: just drag better /shrug


# rune data
## name
## atk points
const


# inventory data
## holds 3 runes at all times
## after dragging and dropping a rune from the inventory, replace it (might not have time)


# board data
## 3 player runes with stats
## 3 enemy runes with stats
## W/L checks?
