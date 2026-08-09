extends Area2D

signal stamped(paper: String)


func _on_area_entered(area):
    if area.name == "DenyStamp":
        var bodies = get_overlapping_bodies()
        for body in bodies:
            if not body.name.ends_with("Paper"):
                continue
            stamped.emit(body.name)
