extends Node2D

@onready var _invisible_walls: TileMapLayer = %InvisibleWalls
@onready var _teleporter: Area2D = %Teleporter
@onready var _end_menu: Control = %EndMenu

func _ready() -> void:
	_invisible_walls.hide()
	_teleporter.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_end_menu.open()
	)
