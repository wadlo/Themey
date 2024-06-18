extends Button

@export var rootNode: Control;
@export var fullBackgroundTexture: Texture;
@export var fullBackgroundNode: TextureRect;

func _ready():
	pressed.connect(onPressed);
	
func onPressed():
	rootNode.theme = theme;
	fullBackgroundNode.texture = fullBackgroundTexture;
