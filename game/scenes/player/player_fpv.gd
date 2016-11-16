extends RigidBody

var mouse_speed = 0.2

var X = 0.00
var Y = 0.00
var speed = 0.1 #Player speed
var mouse_pos = Vector2()


#func _change_camera(cam):
#
#	var id = self.get_node("Camera").get_instance_ID()
#	if id == cam:
#		immerse_me()
#	else:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		set_fixed_process(false)
#		set_process_unhandled_input(false)


func immerse_me():

	self.get_node("Camera").make_current()
	mouse_pos = get_viewport().get_mouse_pos()
	#Hide and capture mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_fixed_process(true)
	set_process_unhandled_input(true)


func _fixed_process(delta):
	#Player movement
	if Input.is_action_pressed("move_forward"):
		translate(Vector3(0, 0, -speed))
	if Input.is_action_pressed("move_backward"):
		translate(Vector3(0, 0, speed))
	if Input.is_action_pressed("strafe_left"):
		translate(Vector3(-speed, 0, 0))
	if Input.is_action_pressed("strafe_right"):
		translate(Vector3(speed, 0, 0))

	var new_mouse_pos = get_viewport().get_mouse_pos()
	var rel_mpos = new_mouse_pos - mouse_pos
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and rel_mpos != Vector2(0,0):

		X += lerp(0, rel_mpos.x, delta) * mouse_speed

		self.set_rotation(Vector3(0, -X, 0))

		Y += lerp(0, rel_mpos.y, delta) * mouse_speed

		if(not Y > 1.5):
			get_node("Camera").set_rotation(Vector3(-Y,0,0))
		else:
			Y = 1.5
		if(not Y < -1.5):
			get_node("Camera").set_rotation(Vector3(-Y,0,0))
		else:
			Y = -1.5

		mouse_pos = new_mouse_pos
#		Input.warp_mouse_pos(get_viewport().get_visible_rect())

func _unhandled_input(event):

	if Input.is_mouse_button_pressed(1):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#		mouse_pos = event.pos

	#Show mouse
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _ready():
	if self.get_node("Camera").is_current():
		immerse_me()

	get_node("Camera").connect("_change_camera", self, "_change_camera")