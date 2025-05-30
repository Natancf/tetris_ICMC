
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
                        - [x] verificar se há colisão à esquerda
				- [x] mov direita (atualiza posição)
					- [x] verificar se é possível mover com base na cópia do mapa
                        - [x] verificar se há colisão à direita
				- [x] rotaciona (atualiza t_peca)
				- [ ] mov baixo pelo input *
				- [ ] descer de uma vez *
		- [x] verificar se moveu peca
			- caso sim	
				- [x] apaga desenho da peca
				- [x] desenha peca
	- [x] descer peca (automaticamente)
		- [x] delay para descer
        - [x] se descer
			- [x] verifica se é possível descer (se está no chão ou se encostou em outra peça) (possivelmente desnecessário verificar se está no chão)
                - [X] se não for possível descer, então
                        - [x] fixa peça
                            - [x] delay antes de fixar a peca
                            - [x] atualiza cp_mapa
                            - [x] flag_spawn <- 1
                            - [x] salvar vetor dos quadradinhos da peça colocada (para verificar se fechou linha)
                            - [x] atualiza t_peca
                - [x] caso seja possivel descer 
                    - [x] atualiza posição
                    - [x] apaga peca
                    - [x] desenha peca
	- [x] verifica se completa linha
		- [x] se True move tudo que esta acima para baixo
			- [x] pontuacao++
	- [x] spawn peca
	- [ ] verificar se perdeu
        - [ ] tela de game over
        - [ ] apresentar a pontuação
        - [ ] jogar novamente

