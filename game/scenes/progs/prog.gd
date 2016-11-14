
extends RigidBody


func jump_to_pos(pos):

	# Apply correct force in correct direction to land at desired pos
	pass

func attack(pos):

	# Spawn projectile near self and set initial velocity
	pass

func _ground_clicked(camera, event, click_pos, click_normal, shape_idx):

	if event.is_action_pressed("move_to"):
		self.jump_to_pos(click_pos)
	elif event.is_action_pressed("attack"):
		self.attack(click_pos)


func _ready():

	# Here I want to get the pos of the mouse click
	get_parent().get_node("Area").connect("input_event", self, "_ground_clicked")