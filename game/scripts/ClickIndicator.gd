extends Spatial


const RAY_LENGTH = 50

onready var anim = self.get_node("AnimationPlayer")

var ray_from = null
var ray_to = null


func set_indicator_pos(input_pos):

	var ray_begin = get_viewport().get_camera().project_position(input_pos)
	var ray_normal = get_viewport().get_camera().project_ray_normal(input_pos)
	var ray_vector = ray_normal * RAY_LENGTH
	var ray_end = ray_begin + ray_vector

	self.ray_from = ray_begin
	self.ray_to = ray_end

	# I can't seem to find a way to tap into the direct space state
	# from outside the _fixed_process() - needs further research
	set_fixed_process(true)


func _animation_finished():
	self.queue_free()


func _fixed_process(delta):

	var space_state = get_world().get_direct_space_state()
	# use global coordinates, not local to node
	var ray_intersect = space_state.intersect_ray( ray_from, ray_to )

	if not ray_intersect.empty():
		var pos = ray_intersect.position
		self.set_translation(pos)
		if get_parent().has_node("Prog"):
			var prog = get_node("../Prog")
			prog.jump_to(pos)

	set_fixed_process(false)


func _ready():
	anim.connect("finished", self, "_animation_finished")
	anim.play("LeftClick")
	pass


