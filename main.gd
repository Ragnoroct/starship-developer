extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _process(delta):
    update()

func _draw():
    for line in global.lines_to_draw:
        draw_line(line.point1, line.point2, line.color)
    global.lines_to_draw = []
