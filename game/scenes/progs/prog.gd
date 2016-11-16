extends RigidBody


var destination = Vector3()
var airborn = false


func attack(pos):

	# Spawn projectile near self and set initial velocity
	pass


func _fixed_process(delta):
	pass


func jump():
	pass


#func _ground_clicked(camera, event, click_pos, click_normal, shape_idx):
#
#	if event.is_action_pressed("move_to"):
#
#		input_area.set_translation(Vector3(click_pos.x, 0, click_pos.z))
#
#		# Apply correct force in correct direction to land at desired pos
#		if self.get_linear_velocity() != Vector3(0,0,0):
#			destination = click_pos
#			return
#		else:
#			destination = click_pos
#			# For testing - still needs proper *jump* calculations:
#			var dir_to_dest = destination - self.get_translation()
#			self.set_linear_velocity(Vector3(4,4,0))
#
#	elif event.is_action_pressed("attack"):
#		self.attack(click_pos)




func _ready():

#	set_process_input(true)
#	set_fixed_process(true)
	pass