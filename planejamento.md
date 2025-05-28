
> [!IMPORTANT]
*Funcionalidades para fazer se houver tempo

Inicialização
- [x] flag_spawn <- 1 //flag_spawn, caso 1, spawna peca

main
- [x] imprime mensagem inicial 
- [x] wait_start
	- [x] var count 
		- [x] inc count -> reset a cada 499 
			- [x] condicao de stop : enter
	- [x] wait enter
- [x] inicia jogo
	- [x] desenha_mapa
	- [x] index inicial do vetor randomico <- count
	- [x] t_peca <- rand[index inicial]
- [x] spawn peca  (pode dar problema futuramente)
	- [x] verifica flag_spawn //caso 0, skip spawn peca
	- [x] verificar t_peca
	- [x] verifica se é possível spawn //caso não seja, GAME OVER (flag_perdeu=1) (não é possível testar ainda)
	- [x] definir posição de spawn
	- [x] desenha peca
		- [x] calc_quads
	- [x] flag_spawn <- 0

MAIN LOOP
   - [x] mover peça
		- [x] verificar input e recalcula posição
			- [x] recalcula posição
			- [x] atualizar posição
				- [x] mov esquerda (atualiza posição)
					- [x] verificar se é possível mover com base na cópia do mapa
				- [x] mov direita (atualiza posição)
					- [x] verificar se é possível mover com base na cópia do mapa
				- [x] rotaciona (atualiza t_peca)
				- [ ] mov baixo pelo input *
				- [ ] descer de uma vez *
		- [x] verificar se moveu peca
			- caso sim	
				- [x] apaga desenho da peca
				- [x] desenha peca
	- [ ] descer peca (automaticamente)
		- [ ] delay para descer
		- [ ] flag se desce ou nao
		- [ ] se down_flag = 1
			- [ ] verifica se é possível descer (se está no chão ou se encostou em outra peça) (possivelmente desnecessário verificar se está no chã)
			- [ ] atualiza posição
			- [ ] apaga peca
			- [ ] desenha peca
			- [ ] atualiza flag para 0 (nao descer)
			
      - [ ] verifica colisão
		- [ ] setar flags de colisão
			- [ ] colisao em baixo
			- [ ] colisao esquerda
			- [ ] colisao direita
			- [ ] colisao em cima *
		- [ ] se colisao em baixo, entao
			- [ ] fixa peca
				- [ ] atualiza mapa (atualizar copia de mapa)
				- [ ] flag_spawn <- 1
				- [ ] vetor temporario da ultima peca <- posicao dos quadradinhos da peca fixada (para depois dividir por 40 (divisao inteira))
	- [ ] verifica se completa linha
		- [ ] se True move tudo que esta acima para baixo
			- [ ] pontuacao++
	- [ ] spawn peca
	- [ ] verificar se perdeu


