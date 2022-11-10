extends Area2D

var speed = 400		# Velocidade da movimentação
var screen_size		# Tamanho da área do jogo

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()		# Esconde inicialmente
	# Obtemos o tamanho da área de jogo
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Zera a velocidade vetorial
	var velocity = Vector2.ZERO
	
	# Vigia o pressionamento da tecla seta à direita (->)
	if Input.is_action_pressed("ui_right"):
		# Aumentamos a velocidade no eixo x
		velocity.x += 1
	
	# Vigia o pressionamento da tecla seta à esquerda (<-)
	if Input.is_action_pressed("ui_left"):
		# Diminuímos a velocidade no eixo y
		velocity.x -= 1
		
	# Vigia o pressionamento da tecla seta acima
	if Input.is_action_pressed("ui_up"):
		# Diminuímos a velocidade no eixo x
		velocity.y -= 1
		
	# Vigia o pressionamento da tecla seta abaixo
	if Input.is_action_pressed("ui_down"):
		# Diminuímos a velocidade no eixo x
		velocity.y += 1
		
	# Ajusta a velocidade de acordo com o parâmetro speed
	if velocity.length() > 0:
		$AnimatedSprite.play()	# Ativa a animação
		# Usa normalized() para corrigir a velocidade vetorial (diagonal)
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite.stop()
		
			
	# A posição final do personagem é dada pela velocidade
	# multiplicada pelo decurso de tempo (delta)
	position += velocity * delta
	
	# Corrige a posição para que o personagem não saia
	# dos limites da tela
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
		
	# AJUSTA A ANIMAÇÃO DE ACORDO COM O MOVIMENTO NO EIXO X
	if velocity.x != 0:
		$AnimatedSprite.animation = "direita"
		$AnimatedSprite.flip_v = false	# Não flipa na vertical
		# Flipa na horizontal se o movimento for para a esquerda
		$AnimatedSprite.flip_h = velocity.x < 0
		
	# AJUSTA A ANIMAÇÃO DE ACORDO COM O MOVIMENTO NO EIXO Y
	if velocity.y != 0:
		$AnimatedSprite.animation = "acima"
		# Flipa na vertical se o movimento for para baixo
		$AnimatedSprite.flip_v = velocity.y < 0
