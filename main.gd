extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass


func _draw():
    draw_line(Vector2(0,0), Vector2(250,250), Color(255, 0, 0), 1)
