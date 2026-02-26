extends Resource
class_name Enemy

@export var title : String
@export var texture : Texture2D
@export var health : float
@export var damage : float
@export var speed: float
@export var drops : Array[Pickups]

@export var collision_shape: Shape2D #Adicionei esta linha para poder configurar o tamanho dos inimigos.
