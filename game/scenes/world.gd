extends Spatial


const RAY_LENGTH = 50


var cameras = []
var current_cam = 0


func spawn_indicator(pos):

	var indicator = preload("res://scenes/click_indicator.tscn").instance()
	self.add_child(indicator)
	indicator.ray_from = get_viewport().get_camera().project_ray_origin(pos)
	indicator.ray_to = indicator.ray_from + get_viewport().get_camera().project_ray_normal(pos) * RAY_LENGTH


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


func _ready():

	cameras = get_tree().get_nodes_in_group("Cameras")

	set_process_unhandled_input(true)



