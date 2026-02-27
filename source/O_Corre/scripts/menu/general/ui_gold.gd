extends Label

func _process(_delta):
	text = "Ouro: " + str(SaveData.gold)
