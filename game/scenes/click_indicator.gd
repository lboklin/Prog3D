extends Spatial


onready var prog = self.get_node("../Prog")

var ray_from = Vector3()
var ray_to = Vector3()


func _animation_finished():
	self.queue_free()


func _fixed_process(delta):

	var space_state = get_world().get_direct_space_state()
	# use global coordinates, not local to node
	var ray_intersect = space_state.intersect_ray( ray_from, ray_to )

	if not ray_intersect.empty():
		prog.destination = ray_intersect.position
		self.set_translation(ray_intersect.position)


func _ready():
	var anim = self.get_node("AnimationPlayer")
	anim.connect("finished", self, "_animation_finished")
	anim.play("LeftClick")

	set_fixed_process(true)
	pass


