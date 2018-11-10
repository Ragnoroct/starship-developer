extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2(0,0)
var acceleration = Vector2(0,0)
var lookVector = Vector2(0,0)
var dir = Vector2(0,0)

const DEAD_ZONE = 0.2

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func _draw():
    var main = get_tree().get_root().get_node("Main")
#    main.draw_line(Vector2(0,0), Vector2(250,250), Color(255, 0, 0), 1)

#    print(position, position + acceleration)

func _process(delta):
#    #Rotate ship
#    var mousePos = get_viewport().get_mouse_position()
##    look_at(mousePos)
#    var lookVector = mousePos - position
#
#    #Move ship
#    var dir = Vector2(0,0)


        
    var dir = getDirection()
    var acceleration = dir * 90000
    velocity = acceleration * delta
    position += velocity * delta
    
    if dir.length() > 0:
        rotation = dir.angle()
    
#    #Add lines for debugging
#    global.add_line(Vector2(0,0), Vector2(250,250), Color(255, 0, 0))
#    global.add_line(position, position + acceleration, Color(255, 0, 0))
#    global.add_line(position, position + dir, Color(0, 0, 255))
#    global.add_line(position, position + velocity, Color(0, 255, 0))
#    global.add_line(position, position + lookVector, Color(0, 255, 0))
    
func getDirection():
    var dir = Vector2(0,0)
    #Calculate from controller
    if Input.get_connected_joypads().size() > 0:
        var xaxis = Input.get_joy_axis(0, JOY_AXIS_0)
        var yaxis = Input.get_joy_axis(0, JOY_AXIS_1)
        xaxis = xaxis if abs(xaxis) > DEAD_ZONE else 0
        yaxis = yaxis if abs(yaxis) > DEAD_ZONE else 0
        dir = Vector2(xaxis, yaxis)
    
    #Calculate from keyboard
    if dir == Vector2(0,0):
        if Input.is_action_pressed("ui_right"):
            dir += Vector2(1, 0)
        if Input.is_action_pressed("ui_left"):
            dir += Vector2(-1, 0)
        if Input.is_action_pressed("ui_up"):
            dir += Vector2(0, -1)
        if Input.is_action_pressed("ui_down"):
            dir += Vector2(0, 1)
    return dir.normalized()

#func updatePulseAnimation(dir):
#    if Input.is_action_pressed("ui_right"):
#        $LeftPulse.play("Start")
#    else:
#        $LeftPulse.play("Stop")
#
#    if Input.is_action_pressed("ui_left"):
#        $RightPulse.play("Start")
#    else:
#        $RightPulse.play("Stop")
#
#    if Input.is_action_pressed("ui_up"):
#        $BackPulse.play("Start")
#    else:
#        $BackPulse.play("Stop")
#
#    if Input.is_action_pressed("ui_down"):
#        $FrontPulse.play("Start")
#    else:
#        $FrontPulse.play("Stop")
        