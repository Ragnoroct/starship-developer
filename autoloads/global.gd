extends Node

class Line:
    var point1
    var point2
    var color

    func _init(point1, point2, color):
        self.point1 = point1
        self.point2 = point2
        self.color = color

var lines_to_draw = []

func add_line(point1, point2, color):
    lines_to_draw.append(Line.new(point1, point2, color))