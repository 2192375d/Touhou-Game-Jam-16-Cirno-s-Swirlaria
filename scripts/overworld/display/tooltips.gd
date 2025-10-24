extends Node2D

var general_text : RichTextLabel

func create_text() -> RichTextLabel:
	general_text = RichTextLabel.new()
	general_text.add_theme_font_size_override("normal_font_size", 32)
	general_text.text = ""
	general_text.position = Vector2(200, 150)
	general_text.size = Vector2(300,100)
	general_text.visible = false
	general_text.z_index = 999
	return general_text

func _ready() -> void:
	
	get_tree().root.add_child(general_text)
	
func _on_display_tooltip(tooltipstr : String, enable : bool) -> void:
	print("hello ?")
	general_text.text = tooltipstr
	general_text.visible = enable
