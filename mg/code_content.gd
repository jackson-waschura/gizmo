@tool
class_name CodeContent
extends TextEdit

enum CODE_LANG {GDSCRIPT_LANG, PYTHON_LANG, CSHARP_LANG}

# TODO: should these be preloaded or not?
const SYNTAX_SETTINGS = {
	CODE_LANG.GDSCRIPT_LANG: preload("res://gizmo/mg/gdscript_syntax_settings.tres")
}

@export
var code_language: CODE_LANG = CODE_LANG.GDSCRIPT_LANG:
	set(value):
		code_language = value
		set_syntax_settings(value)

func _ready():
	set_syntax_settings(code_language)

func set_syntax_settings(lang: CODE_LANG):
	if lang not in SYNTAX_SETTINGS:
		printerr("Language {} not supported!".format([lang]))
	var settings = SYNTAX_SETTINGS[lang]
	settings.configure_code_visuals(self)

func set_code(value):
	text = value
