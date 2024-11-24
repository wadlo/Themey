extends Button

@export var themeCanvasLayer: CanvasLayer;

func _ready():
	pressed.connect(onPressed);
	
func onPressed():
	var allThemes = themeCanvasLayer.get_parent().get_children();
	for theme in allThemes:
		theme.visible = false;
	themeCanvasLayer.visible = true;
