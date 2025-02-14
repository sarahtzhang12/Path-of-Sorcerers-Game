class_name Weapon extends Node2D

@export var bullet_scene: PackedScene = preload("res://bullet.tscn")
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var random_angle := PI / 12.0
@export_range(100.0, 2000.0, 1.0) var max_range := 2000.0
@export_range(100.0, 3000.0, 1.0) var max_bullet_speed := 1500.0
@export var shoot_sound: AudioStreamPlayer = null

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.max_range = max_range
	bullet.speed = max_bullet_speed
	bullet.rotation += randf_range(-random_angle / 2.0, random_angle / 2.0)

	if shoot_sound != null:
		shoot_sound.play()
