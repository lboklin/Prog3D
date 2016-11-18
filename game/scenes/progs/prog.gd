extends RigidBody


var destination = null
var dest_queue = null


func is_airborn():

	var current_pos = self.get_translation()
	if current_pos.y <= 0.02:
		return false
	else:
		return true


func get_jump_initial_velocity(dest):

	## t is the predetermined time of flight
#	var t = max(0.5, min(jump_vector_2D.x * 0.7, 1.5))
	var t = 1

	## angle is the angle at which to launch from the ground
#	var angle = deg2rad(45)

#	var gravity = self.get_weight()

	## get vector to dest
	var my_pos = self.get_translation()
	var jump_vector_3D = dest - my_pos

	## Convert 3D vector into 2D to do some projectile motion math
	## x is the x and the z axes merged together and y is unchanged
	var horizontal_distance = Vector2(jump_vector_3D.x, jump_vector_3D.z).length()
#	var vertical_distance = jump_vector_3D.y
	## get direction to dest in 2D along the ground
	var dir = Vector2(jump_vector_3D.x, jump_vector_3D.z).normalized()
	print(dir.y)

	# Now calculate velocity
	var horizontal_velocity = horizontal_distance / t
	var vertical_velocity = horizontal_velocity
	var initial_velocity = Vector2(horizontal_velocity, vertical_velocity).length()

	## Final velocity translated back into 3D
	var velocity = Vector3()
	velocity.x = horizontal_velocity*dir.x
	velocity.y = vertical_velocity
	velocity.z = horizontal_velocity*dir.y

	return velocity


func attack(pos):

	# Spawn projectile near self and set initial velocity
	pass


func jump_to(dest):

	var airborn = self.is_airborn()

	if not airborn:
		self.destination = dest
	else:
		self.dest_queue = dest

#	return airborn


#func _integrate_forces(state):
#
#	if self.destination != null:
#		state.set_linear_velocity(get_jump_initial_velocity(self.destination))
#		self.destination = null
#	self.set_use_custom_integrator(false)


func _fixed_process(delta):

	var current_pos = self.get_translation()
	if self.is_airborn():
		return

	if self.dest_queue != null:
		self.destination = self.dest_queue
		self.dest_queue = null

	if self.destination != null:
		var v = self.get_jump_initial_velocity(self.destination)
		if v != null:
			self.set_linear_velocity(v)
#			self.set_fixed_process(false)
			self.destination = null


func _ready():
	set_fixed_process(true)
	pass
