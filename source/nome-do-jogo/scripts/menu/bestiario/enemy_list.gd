extends VBoxContainer

const path = "res://resources/enemies/"

var enemies = []

func _ready():
	dir_contents()

func dir_contents():
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("Achei o arquivo: " + file_name)
			
			var enemy_resource: Enemy = load(path + file_name)
			enemies.append(enemy_resource)
			
			var button = Button.new()
			button.pressed.connect(_on_pressed.bind(button))
			button.text = enemy_resource.title
			var black = Color(0.0, 0.0, 0.0, 1.0)
			button.set("theme_override_colors/font_color",black)
			add_child(button)
			_on_pressed(button)
			
			file_name = dir.get_next()
	else:
		print("Ocorreu um erro ao tentar acessar o caminho.")
	print(enemies)

func _on_pressed(button: Button):
	var index = button.get_index()
	%Name.text = "Nome: " + enemies[index].title
	%Health.text = "Vida: " + str(enemies[index].health)
	%Damage.text = "Dano: " + str(enemies[index].damage)
	%Texture.texture = enemies[index].texture
	SoundManager.play_sfx(load("res://assets/sounds/sfx/button_menu_sound.wav"))
