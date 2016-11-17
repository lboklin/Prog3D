extends Spatial


var cameras = []
var current_cam = 0


func spawn_indicator(pos):

	var indicator = preload("res://scenes/click_indicator.tscn").instance()
	self.add_child(indicator)
	indicator.set_indicator_pos(pos)


func break_my_immersion():
	var firstperson = get_node("PlayerFPV")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	firstperson.set_fixed_process(false)
	firstperson.set_process_unhandled_input(false)


func change_cam():

	var cam = get_viewport().get_camera()
#		current_cam = cameras.find(cam)

#		cameras[current_cam].clear_current()
#		cameras.push_back(0)
#		var new_cam = cameras[0]
#		get_tree().call_group(0, "Cameras", "_change_camera", cameras[0].get_instance_ID())

	if cam.get_name() == "InterpolatedCamera":
		if cam.get_projection() == cam.PROJECTION_ORTHOGONAL:
			cam.set_perspective(60, 0.01, 100)
		else:
			get_node("PlayerFPV/Camera").make_current()
			get_node("PlayerFPV").immerse_me()
	else:
		get_node("InterpolatedCamera").make_current()
		self.break_my_immersion()


func _unhandled_input(event):

	if event.is_action_pressed("move_to"):
		self.call_deferred("spawn_indicator", event.pos)
	elif event.is_action_pressed("change_camera"):
		self.change_cam()
	elif event.is_action_released("quit_game"):
		get_tree().quit()


func _ready():

	cameras = get_tree().get_nodes_in_group("Cameras")

	set_process_unhandled_input(true)



