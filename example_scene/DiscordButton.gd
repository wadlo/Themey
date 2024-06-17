extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(onPressed);
	
func onPressed():
	OS.shell_open("https://discord.gg/MJHRSjB9yH");
	
		
