extends RigidBody


var destination = null
var dest_queue = null
var airborn = false


func attack(pos):

	# Spawn projectile near self and set initial velocity
	pass


func jump(dest):

	var current_pos = self.get_translation()
	destination = dest

	if airborn:
		dest_queue = dest
		return
	else:
		dest_queue = null

	## get length and dir to dest
	var jump_vector_3D = dest - current_pos
	## dir is direction along the ground
	var dir = Vector2(jump_vector_3D.x, jump_vector_3D.z).normalized()

	## Convert 3D into 2D
	## jump_vector_2D.x is distance along ground
	## jump_vector_2D.y is difference in elevation - most likely 0
	var jump_vector_2D = Vector2(0, 0)
	jump_vector_2D.x = Vector2(jump_vector_3D.x, jump_vector_3D.z).length()
#	jump_vector_2D.y = jump_vector_3D.y

	## t is the predetermined time of flight
#	var t = max(0.5, min(jump_vector_2D.x * 0.7, 1.5))
	var t = 1
	## angle is the angle at which to launch from the ground
	var angle = deg2rad(45)

	var velocity_2D = Vector2()
	velocity_2D.x = jump_vector_2D.x
	velocity_2D.y = velocity_2D.x
#	velocity_2D *= angle
	velocity_2D *= sin(2*angle)

	## Final velocity translated into 3D
	var velocity = Vector3()
	velocity.x = jump_vector_3D.x / t
#	velocity.x = velocity_2D.x*dir.x
	velocity.y = velocity_2D.y
#	velocity.y = velocity_2D.x * angle / t
	velocity.z = jump_vector_3D.z / t
#	velocity.z = velocity_2D.x*dir.y

	## Apply
	self.set_linear_velocity(velocity)
	airborn = true



func _fixed_process(delta):

	var current_pos = self.get_translation()
	if airborn:
		if current_pos.y <= 0.02:
			airborn = false
	else:
		if destination != null and (destination - current_pos).length() >= 5:
			# Set breakpoint here for debug
			pass
		return

	if dest_queue != null:
		jump(dest_queue)
		dest_queue = null


func _ready():
	set_fixed_process(true)
	pass
