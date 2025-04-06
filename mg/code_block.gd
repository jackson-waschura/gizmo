@tool
extends Control

@onready var root_panel: PanelContainer = $PanelContainer
@onready var header: Label = $PanelContainer/MarginContainer/MainVBoxContainer/Header
@onready var content: CodeContent = $PanelContainer/MarginContainer/MainVBoxContainer/Content

@export
var width: int = 100:
	set(value):
		width = value
		_update_panel_size()
@export
var height: int = 100:
	set(value):
		height = value
		_update_panel_size()
@export
var header_size: int = 18:
	set(value):
		header_size = value
		_update_header_font()
@export
var content_size: int = 14:
	set(value):
		content_size = value
		_update_content_font()
@export
var title: String = "Header":
	set(value):
		title = value
		_update_header_string()
@export_multiline
var code: String = "func _my_function(arg1, arg2, arg3, arg4, arg5):
	# This method prints and returns a sum
	print(\"Hello World!\")
	return arg1 + arg2 + arg3":
	set(value):
		code = value
		_update_content_string()

func _ready():
	_update_panel_size()

func _update_panel_size():
	if not root_panel:
		return
	root_panel.custom_minimum_size = Vector2(width, height)

func _update_header_font():
	if not header:
		return
	header.add_theme_font_size_override("font_size", header_size)

func _update_content_font():
	if not content:
		return
	content.add_theme_font_size_override("font_size", content_size)
	_update_content_size()

func _update_content_string():
	if not content:
		return
	content.set_code(code)
	_update_content_size()

func _update_header_string():
	if not header:
		return
	header.text = title

func _update_content_size():
	if not content:
		return
	var num_lines: int = content.get_line_count()
	var max_width: int = 0
	for i in range(num_lines):
		max_width = max(max_width, content.get_line_width(i))
	var min_size = content.custom_minimum_size
	min_size[0] = max_width + 15
	content.custom_minimum_size = min_size
