extends Node

var music_player: AudioStreamPlayer
var current_track: String = "NO TRACK"

const MUSIC_BUS = "BGM"
const SFX_BUS = "SFX"

var bus_volumes: Dictionary[String, float] = {
    "BGM": 0.5,
    "SFX": 0.5,
}

var music_is_muted: bool = false
var sfx_is_muted: bool = false


func _ready():
    if AudioServer.get_bus_index(MUSIC_BUS) == -1:
        push_error("Audio Bus \"%s\" not found" % MUSIC_BUS)
    
    if not music_player: 
        music_player = AudioStreamPlayer.new()
        music_player.bus = MUSIC_BUS
        add_child(music_player)
    
    for bus in bus_volumes.keys():
        set_bus_volume(bus, bus_volumes[bus])


## Plays a track on loop.  Requesting an additional track ends the current one.
##
## example:
## ```
## const FUNKY_MUSIC = preload("res://assets/sound/funky_music.ogg")
##
## AudioManager.request_track(FUNKY_MUSIC)
## ```
func request_track(stream: AudioStream, fade_in: float = 0.5, restart: bool = false):
    if not restart and music_player:
        if stream == music_player.stream:
            return

    music_player.stream = stream
    music_player.volume_linear = 0
    music_player.play()
    create_tween().tween_property(music_player, "volume_linear", bus_volumes[MUSIC_BUS], fade_in)


## Plays an SFX once and then dumps the node in the incinerator.
##
## example:
## ```
## const ATTACK_SCHWING = preload("res://assets/sound/attack_schwing.ogg")
##
## AudioManager.request_sfx(ATTACK_SCHWING)
## ```
func request_sfx(stream: AudioStream):
    var player := AudioStreamPlayer.new()
    player.stream = stream
    player.bus = SFX_BUS
    add_child(player)
    player.play()
    player.finished.connect(player.queue_free)


## Pauses music
func pause_music():
    music_player.stream_paused = true

## Unpauses paused music
func unpause_music():
    music_player.stream_paused = false


## Starts stopped music
func play_music():
    music_player.play()

## Stops started music
func stop_music():
    music_player.stop()


## Sets the volumn of an audio bus.
func set_bus_volume(bus_name: String, linear: float):
    var idx: int = AudioServer.get_bus_index(bus_name)
    if idx == -1:
        return
        
    bus_volumes[bus_name] = clampf(linear, 0.0, 1.0)

    AudioServer.set_bus_volume_db(
        idx,
        linear_to_db(bus_volumes[bus_name])
    )
