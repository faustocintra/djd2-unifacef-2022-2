extends RigidBody2D

export var min_speed = 150
export var max_speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	# Obtém os nomes dos diferentes tipos de animação do inimigo
	var tipo_inimigos = $AnimatedSprite.frames.get_animation_names()
	# Escolhe uma animação aleatória para o inimigo
	$AnimatedSprite.animation = tipo_inimigos[randi() % tipo_inimigos.size()]



func _on_VisibilityNotifier2D_screen_exited():
	# Libera a memória ocupada pelo inimigo quando ele sai da tela
	queue_free()
