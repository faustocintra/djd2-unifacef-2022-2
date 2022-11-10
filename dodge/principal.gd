extends Node

export (PackedScene) var Inimigo
var score

func _ready():
	randomize()
	novo_jogo()
	
func novo_jogo():
	score = 0
	$inicioTimer.start()

func _on_jogador_hit():
	# O jogador bateu em um inimigo; GAME OVER
	score = 0
	# Reposiciona o jogador na posição inicial
	# jogador.start($posicaoInicial.position)
	# Reinicia o timer de início
	$inicioTimer.start()


func _on_inicioTimer_timeout():
	# Inicia os outros dois timers
	$inimigoTimer.start()
	$pontuacaoTimer.start()

func _on_pontuacaoTimer_timeout():
	# Incrementa o placar
	score += 1


func _on_inimigoTimer_timeout():
	# Calcula uma posição aleatória para o inimigo
	$caminhoInimigo/spawnInimigo.offset = randi()
	# Instancia o inimigo
	var inimigo = Inimigo.instance()
	# Adiciona o inimigo à cena
	add_child(inimigo)
