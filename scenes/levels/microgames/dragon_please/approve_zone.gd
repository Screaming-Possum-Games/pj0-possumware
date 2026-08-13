extends Area2D

signal stamped(paper: String)
const STAMP_SFX: AudioStream = preload("res://assets/dragon_please/256763__radwoc__piecz_14.wav")


func _on_area_entered(area):
    if area.name == "ApproveStamp":
        var bodies = get_overlapping_bodies()
        for body in bodies:
            if not body.name.ends_with("Paper"):
                continue
            stamped.emit(body.name)
        AudioManager.request_sfx(STAMP_SFX)
