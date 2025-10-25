extends Node

func create_text(text : String, pos : Vector2) -> RichTextLabel:
	var general_text : RichTextLabel = RichTextLabel.new()
	general_text.add_theme_font_size_override("normal_font_size", 10)
	general_text.text = text #"Space to Interact"
	general_text.position = pos #Vector2(5, 20)
	general_text.size = Vector2(300,100)
	general_text.visible = false
	general_text.z_index = 999
	return general_text
