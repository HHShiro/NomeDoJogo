extends VBoxContainer

@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider

const MIN_DB = -60
const MAX_DB = -3.0

func _ready() -> void:
	sync_slider()
	
	master_slider.value_changed.connect(on_master_volume_changed)
	music_slider.value_changed.connect(on_music_volume_changed)
	sfx_slider.value_changed.connect(on_sfx_volume_changed)

func sync_slider():
	master_slider.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_slider.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))



func slider_to_db(value: float) -> float:
	if value <= 0.0:
		return MIN_DB
	
	var linear = value / 100
	var db = linear_to_db(linear)
	return clamp(db, MIN_DB, MAX_DB)

func db_to_slider(db: float) -> float:
	if db <= MIN_DB:
		return 0.0
	var linear = db_to_linear(db)
	return clamp(linear * 100.0, 0.0, 100.0)

func set_volume(bus_name: String, value: float):
	var db = slider_to_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)
	AudioServer.set_bus_mute(bus_index, db <= MIN_DB)

func on_master_volume_changed(value: float):
	set_volume("Master", value)

func on_music_volume_changed(value: float):
	set_volume("Music", value)

func on_sfx_volume_changed(value: float):
	set_volume("SFX", value)
