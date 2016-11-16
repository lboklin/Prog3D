extends Spatial


const RAY_LENGTH = 50

#onready var ray = self.get_node("InterpolatedCamera/RayCast")
#onready var indicator = preload("res://scenes/click_indicator.tscn").instance()
#onready var prog = self.get_node("GridMap/Prog")

#var ray_from = Vector3()
#var ray_to = Vector3()


func spawn_indicator(pos):

	var indicator = preload("res://scenes/click_indicator.tscn").instance()
	self.add_child(indicator)
	indicator.ray_from = get_viewport().get_camera().project_ray_origin(pos)
	indicator.ray_to = indicator.ray_from + get_viewport().get_camera().project_ray_normal(pos) * RAY_LENGTH


#func _fixed_process(delta):
#
#	if self.has_node("ClickIndicator") and not get_node("ClickIndicator").is_queued_for_deletion():
#		var space_state = get_world().get_direct_space_state()
#		# use global coordinates, not local to node
#		var ray_intersect = space_state.intersect_ray( ray_from, ray_to )
#
#		if not ray_intersect.empty():
#			prog.destination = ray_intersect.position
#			indicator.set_translation(ray_intersect.position)


func _input(event):

	if event.is_action_pressed("move_to"):
		self.call_deferred("spawn_indicator", event.pos)


func _ready():
	set_process_input(true)
#	set_fixed_process(true)
	pass



