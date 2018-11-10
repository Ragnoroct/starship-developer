extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2(0,0)
var acceleration = Vector2(0,0)
var lookVector = Vector2(0,0)
var dir = Vector2(0,0)

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func _draw():
    var main = get_tree().get_root().get_node("Main")
    main.draw_line(Vector2(0,0), Vector2(250,250), Color(255, 0, 0), 1)
    main.draw_line(position, position + acceleration, Color(255, 0, 0), 1)
    main.draw_line(position, position + dir, Color(0, 0, 255), 1)
    main.draw_line(position, position + velocity, Color(0, 255, 0), 1)
    print(position, position + acceleration)

func _process(delta):
    #Rotate ship
    var mousePos = get_viewport().get_mouse_position()
    look_at(mousePos)
    var lookVector = mousePos - position
    
    #Move ship
    var dir = Vector2(0,0)
    if Input.is_action_pressed("ui_right"):
        dir += Vector2(lookVector.x, -lookVector.y).normalized()
    if Input.is_action_pressed("ui_left"):
        dir += Vector2(-lookVector.x, lookVector.y).normalized()
    if Input.is_action_pressed("ui_up"):
        dir += Vector2(lookVector.x, lookVector.y).normalized()
    if Input.is_action_pressed("ui_down"):
        dir += Vector2(-lookVector.x, -lookVector.y).normalized()
    #dir = dir.rotated(position.angle_to_point(mousePos))
    var acceleration = dir * 250
    velocity += acceleration * delta
    position += velocity * delta
    updatePulseAnimation(dir)
    
    self.acceleration = acceleration
    self.dir = dir
    update()
    

func updatePulseAnimation(dir):
    if Input.is_action_pressed("ui_right"):
        $LeftPulse.play("Start")
    else:
        $LeftPulse.play("Stop")
        
    if Input.is_action_pressed("ui_left"):
        $RightPulse.play("Start")
    else:
        $RightPulse.play("Stop")
        
    if Input.is_action_pressed("ui_up"):
        $BackPulse.play("Start")
    else:
        $BackPulse.play("Stop")
        
    if Input.is_action_pressed("ui_down"):
        $FrontPulse.play("Start")
    else:
        $FrontPulse.play("Stop")
        