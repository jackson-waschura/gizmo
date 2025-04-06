@tool
class_name CodeSyntaxSettings
extends Resource

# Syntax Highlighting Definitions
@export
var keywords: Array[String] = []
@export
var cf_keywords: Array[String] = []
@export
var builtins: Array[String] = []
@export
var comment_indicator: String = "#"

# Syntax Highlighting Colors
@export
var normal_color: Color = Color(0.75, 0.80, 0.81, 1.0)
@export
var symbol_color: Color = Color(0.67, 0.79, 1.0, 1.0)
@export
var keyword_color: Color = Color(1.0, 0.43, 0.51, 1.0)
@export
var cf_keyword_color: Color = Color(1.0, 0.55, 0.80, 1.0)
@export
var builtin_color: Color = Color(0.25, 1.0, 0.75, 1.0)
@export
var comment_color: Color = Color(0.75, 0.80, 0.81, 0.5)
@export
var string_color: Color = Color(1.0, 0.93, 0.62, 1.0)
@export
var number_color: Color = Color(0.62, 1.0, 0.87, 1.0)
@export
var function_color: Color = Color(0.4, 0.89, 1.0, 1.0)


func configure_code_visuals(content: CodeContent):
	# Set the normal color
	content.add_theme_color_override("font_color", normal_color)
	
	# Get the highlighter or instantiate a new one
	var highlighter: CodeHighlighter
	if content.syntax_highlighter:
		highlighter = content.syntax_highlighter
		highlighter.clear_color_regions()
		highlighter.clear_keyword_colors()
	else:
		highlighter = CodeHighlighter.new()
	
	# Set simple category colors
	highlighter.number_color = number_color
	highlighter.symbol_color = symbol_color
	highlighter.function_color = function_color
	
	# Set color regions
	highlighter.add_color_region(comment_indicator, "", comment_color, true)
	highlighter.add_color_region("\"", "\"", string_color, false)
	
	# Set Keywords
	for str in keywords:
		highlighter.add_keyword_color(str, keyword_color)
	
	# Set Control Flow Keywords
	for str in cf_keywords:
		highlighter.add_keyword_color(str, cf_keyword_color)
	
	# Set Builtins
	for str in builtins:
		highlighter.add_keyword_color(str, builtin_color)
	
	# Emit changed signal on the resource in case it was reused
	highlighter.emit_changed()
