extends Control

func _ready():
	menu()
	
func _on_upgrades_pressed() -> void:
	skill_tree()


func _on_book_pressed() -> void:
	book()


func _on_exit_pressed() -> void:
	get_tree().quit()

func menu():
	$menu.show()
	$skill_tree.hide()
	$book.hide()
	$gold.hide()
	$back.hide()

func skill_tree():
	$skill_tree.show()
	$book.hide()
	$gold.show()
	$back.show()

func book():
	$book.show()
	$menu.hide()
	$gold.hide()
	$back.show()


func _on_back_pressed() -> void:
	menu()
