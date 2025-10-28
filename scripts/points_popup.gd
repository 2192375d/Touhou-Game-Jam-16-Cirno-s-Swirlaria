extends Control

@onready var particlehandler : CPUParticles2D = get_node("CPUParticles2D")
@onready var texthandler : RichTextLabel = get_node("PanelContainer/RichTextLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_popup(text : String) -> void:
	visible = true
	texthandler.text = text
	particlehandler.emitting = true
 
func _on_cpu_particles_2d_finished() -> void:
	texthandler.text = ""
	visible = false
