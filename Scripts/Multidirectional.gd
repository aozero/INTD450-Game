extends KinematicBody

const NUM_DIRECTIONS = 4
const UP = Vector3(0, 1, 0)

onready var anim_player = $AnimationPlayer
onready var sprite = $CollisionShape/Sprite3D

var degree_cutoff = 360 / NUM_DIRECTIONS

var old_direction = 0
var player = null

func _ready():
	add_to_group("multidirectionals")

# Called by Player
func set_player(p):
	player = p

func _process(delta):
	#var direction = round(rotation_degrees
	sprite.look_at(Vector3(player.global_transform.origin.x, sprite.global_transform.origin.y, player.global_transform.origin.z), UP)
	sprite.rotation_degrees.y += 180
	
	var sprite_direction = round(sprite.rotation_degrees.y/degree_cutoff)
	if sprite_direction == NUM_DIRECTIONS:
		sprite_direction = 0
	
	if old_direction != sprite_direction:
		old_direction = sprite_direction
		update_sprite_direction()

func update_sprite_direction():
	if anim_player.is_playing():
			var anim_time = anim_player.current_animation_position
			var anim_name = anim_player.current_animation
			
			anim_name = anim_name.substr(0, anim_name.length()-1) + String(old_direction)
			anim_player.play(anim_name)
			anim_player.advance(anim_time)
	