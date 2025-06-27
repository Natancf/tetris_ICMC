
> [!IMPORTANT]
*Funcionalidades para fazer se houver tempo

Inicialização
- [x] flag_spawn <- 1 //flag_spawn, caso 1, spawna peca
- [x] flag_perdeu <- 0

main
- [x] imprime mensagem inicial 
- [x] wait_start
	- [x] var count 
		- [x] inc count -> reset a cada 699 
			- [x] condicao de stop : enter
	- [x] wait enter
- [x] inicia jogo
	- [x] desenha_mapa
	- [x] index inicial do vetor randomico <- count
	- [x] t_peca <- rand[index inicial
        - t_peca indica qual peça e qual rotação a peça atualmente controlada pelo jogador está.
- [x] spawn peca
	- [x] verifica flag_spawn //caso 0, skip spawn peca
	- [x] verificar t_peca
    - [x] definir posição de spawn
	- [x] verifica se é possível spawn //caso não seja, GAME OVER (flag_perdeu=1) (não é possível testar ainda)
        - [x] verificar com base em cp_mapa, que é uma cópia do mapa contendo os quadradinhos ocupados no mapa
	- [x] desenha peca
		- [x] calc_quads - calcula a posição dos quadradinhos da atual t_peca com base na posição central da peça
	- [x] flag_spawn <- 0

MAIN LOOP
   - [x] mover peça (mv_peca)
		- [x] recalc_pos (recalcular posição)
            - [x] verificar input do jogador (se a, w ou d)
                - [x] caso 'd', call mv_dir
                    - [x] verificar se é possível mover com base em cp_mapa
                        - [x] calc_quads - calcular a posicao dos quadradinhos da peca sendo controlada
                        - [x] com base em calc_quads, verificar a posicao à direita dos quadradinhos
                            - [x] caso a posição à direita esteja ocupada, manter pos
                    - [x] caso seja possivel mover, incrementar pos
                - [x] caso 'a', call mv_esq
                    - [x] mesmo esquema de mv_esq para verificar se é possível mover
                    - [x] caso seja possível mover, decrementar pos
                - [x] caso 'w', call rotate
                    - [x] alterar temporariamente valor de t_peca para a próxima rotação
                    - [x] call calc_quads - calcular a posição dos quadradinhos na próxima rotação 
                    - [x] com base nas posições retornadas por calc_quads, verificar se nenhuma posição indica um quadradinho do mapa já ocupado
                        - [x] caso alguma posição seja um quadradinho ocupado, restaurar t_peca
                        - [x] caso contrário, manter t_peca atualizado
		- [x] verificar se moveu peca
			- caso sim	
				- [x] apaga peca
				- [x] desenha peca
        - [x] verificar se rotacionou peça
            -caso sim
                - [x] apaga peça
                - [x] desenha peça        
	- [x] descer peca
			- [x] verifica se é possível descer (se está no chão ou se encostou em outra peça)
            - [X] se não for possível descer, então
                    - [x] fixa peça
                        - [x] delay antes de fixar a peca
                        - [x] atualiza cp_mapa - marca como ocupado a posição dos quadradinhos da peça fixada
                        - [x] flag_spawn <- 1
                        - [x] salvar vetor da posição dos quadradinhos da peça colocada (para verificar se fechou linha)
                        - [x] atualiza t_peca com novo valor do vetor de peças randômicas.
            - [x] caso seja possivel descer 
                - [x] atualiza posição (soma 40 em pos)
                - [x] apaga peca
                - [x] desenha peca
	- [x] verifica se completa linha
        - [x] verifica vetor das posições dos quadradinhos da última peça colocada e verifica as linhas dessas posições
		- [x] para cada linha completada
			- [x] pontuacao++
            - [x] move linhas acima para baixo inclusive as posicoes do vetor das posições dos últimos quadradinhos colocados
	- [x] spawn peca
	- [x] verificar se perdeu (verificar se flag_perdeu == 1)
        - [x] reseta cp_mapa, marcando todos as posições do mapa como não ocupadas
        - [x] chama função de desenhar tela de game over
        - [x] apresentar a pontuação
        - [x] wait_espacebar
            - [x] reset da flag perdeu (setar para 0)
            - [x] caso o jogador pressionar espaço (jogar novamente), jump para label retry acima de start_game em main

