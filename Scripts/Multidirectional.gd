extends KinematicBody

const NUM_DIRECTIONS = 4
const UP = Vector3(0, 1, 0)

onready var top_looker = $TopLooker
onready var sprite_looker = $TopLooker/SpriteLooker
onready var anim_player = $AnimationPlayer
onready var player = get_tree().get_root().get_node("World/Player")

var degree_cutoff = 360 / NUM_DIRECTIONS

var old_sprite_direction = 0

func _ready():
	top_looker.rotation_degrees.y = rotation_degrees.y
	rotation_degrees = Vector3(0, 0, 0)
	set_in_player_area(false)

# Called by Player Area
func set_in_player_area(value):
	set_process(value)
	set_physics_process(value)

func _process(delta):
	sprite_looker.look_at(Vector3(player.global_transform.origin.x, sprite_looker.global_transform.origin.y, player.global_transform.origin.z), UP)
	sprite_looker.rotation_degrees.y += 180

	var sprite_direction = round(sprite_looker.rotation_degrees.y/degree_cutoff)
	if sprite_direction == NUM_DIRECTIONS:
		sprite_direction = 0

	if old_sprite_direction != sprite_direction:
		old_sprite_direction = sprite_direction
		update_sprite_direction()

func update_sprite_direction():
	if anim_player.is_playing():
			var anim_time = anim_player.current_animation_position
			var anim_name = anim_player.current_animation

			anim_name = anim_name.substr(0, anim_name.length()-1) + String(old_sprite_direction)
			anim_player.play(anim_name)
			anim_player.advance(anim_time)
