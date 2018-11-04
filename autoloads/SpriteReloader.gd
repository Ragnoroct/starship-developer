extends Node

const CHECK_INTERVAL = .3

var spriteDict = {}
var timer

func _ready():
    timer = Timer.new()
    timer.wait_time = CHECK_INTERVAL
    timer.autostart = true
    timer.start()
    timer.connect("timeout", self, "_check_texture_timestamps")
    add_child(timer)

func watch_sprite(sprite):
    var id = sprite.get_instance_id()
    #save texture path to save it
    spriteDict[id] = [sprite, find_texture_time(sprite)] 

func find_texture_time(sprite):
    var file
    var texture_path
    var modified
    texture_path = sprite.texture_path
    file = File.new()
    file.open(texture_path, File.READ)
    modified = file.get_modified_time(texture_path)
    file.close()
    return modified
    
func _check_texture_timestamps():
    for spriteId in spriteDict:
        var sprite = spriteDict[spriteId][0]
        var modified = find_texture_time(sprite)
        if modified > spriteDict[spriteId][1]:
            sprite.reload_texture()
            spriteDict[spriteId][1] = modified
