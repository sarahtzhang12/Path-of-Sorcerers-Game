class_name Bullet extends Area2D

@export var speed := 750
var max_range := 1000.0

@export var damage := 1

@export var hit_sound: AudioStreamPlayer = null

var _traveled_distance = 0.0

func _physics_process(delta: float) -> void:
	var distance := speed * delta
	var motion := Vector2.RIGHT.rotated(rotation) * distance
	position += motion 
	
	_traveled_distance += distance
	if _traveled_distance > max_range:
		_destroy() 

func _destroy():
	if hit_sound != null:
		hit_sound.play()
		set_deferred("monitoring", false)
		set_physics_process(false)
		hide()
		hit_sound.finished.connect(queue_free)
	else:
		queue_free()

func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		if body is Mob:
			body.health -= damage
	)
