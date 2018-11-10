extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func _process(delta):
    var dir = Vector2(0,0)
    if Input.is_action_pressed("ui_right"):
        dir += Vector2(1,0)
    if Input.is_action_pressed("ui_left"):
        dir += Vector2(-1,0)
    if Input.is_action_pressed("ui_up"):
        dir += Vector2(0,-1)
    if Input.is_action_pressed("ui_down"):
        dir += Vector2(0,1)
    
    move_ship(dir)

func _input(event):
    if event is InputEventMouseMotion:
        var lookDir = event.position - position
        lookDir = lookDir.normalized();
        rotation = lookDir.angle()
        print("Mouse Motion at: ", lookDir)

func move_ship(dir):
    self.position += dir * 10