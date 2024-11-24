class_name ThemeyButton extends Button

# Track the hover state manually
var is_hovered: bool = false

static func adjust_brightness_on_hover(button: Button, is_hovered: bool, is_pressed: bool) -> void:
	# Get the shader material from the button
	var shader_material = button.material as ShaderMaterial

	# Adjust the brightness of the button when hovered or pressed
	if is_pressed and is_hovered:
		shader_material.set_shader_parameter("brightness_adjust", -0.5)
	elif is_hovered:
		shader_material.set_shader_parameter("brightness_adjust", 0.5)
	else:
		shader_material.set_shader_parameter("brightness_adjust", 0.0)

func _ready() -> void:
	# Connect the signals for mouse enter and exit
	self.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	self.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false

func _process(delta: float) -> void:
	var is_pressed = is_pressed()

	# Call the static function to adjust brightness based on hover or press state
	adjust_brightness_on_hover(self, is_hovered, is_pressed)
