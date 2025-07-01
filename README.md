# tetris_ICMC

## Descrição

Este projeto é uma implementação do clássico jogo Tetris em Assembly, criado para o processador do [ICMC](https://github.com/simoesusp/Processador-ICMC).

## Como executar tetris_ICMC

1. Faça download do arquivo `giroto_tetris.asm` e `charmap.mif`
2. Abra o simulador do processador [simulador processador giroto](https://proc.giroto.dev/)
3. Na aba `Screen editor` import o arquivo `charmap.mif` para o simulador
4. Na aba `File picker` import o arquivo `giroto_tetris.asm` para o simulador
5. Com o arquivo aberto Aperte em `Build` para montar o programa
6. Na aba `State` do simulador aperte em `Run` para executar o jogo

<!--Os projetos devem conter um Readme explicando o projeto e o software deve estar muito bem comentado!!-->
## Controles
`a` 🠖 move peça para direita 

`d` 🠖 move peça para esquerda 

`w` 🠖 gira peça 

## Como o Jogo foi feito
### Arquitetura Principal e Fluxo do Jogo
O motor do jogo é centrado em um MAIN LOOP que gerencia o estado do jogo de forma contínua. O fluxo principal é o seguinte:

1. Inicialização: O jogo começa apresentando uma mensagem inicial e aguarda o jogador pressionar a tecla de início (wait_start). Durante essa espera, um contador é utilizado para gerar um índice semi-aleatório, que define a primeira peça a ser gerada.

2. Início do Jogo: Após a confirmação, o mapa é desenhado na tela, e a primeira peça é definida com base no índice gerado. O controle então passa para o loop principal.

3. Fim de Jogo: A partida termina quando uma peça tenta ser gerada (spawn) em um espaço já ocupado. Isso ativa uma flag (flag_perdeu), que aciona a tela de "Game Over", exibe a pontuação final e aguarda o jogador decidir se quer jogar novamente, reiniciando o ciclo.

### Controle e Manipulação da Peça
A interação do jogador e a física da peça são os componentes mais complexos:

* Movimento e Rotação (mv_peca): Em intervalos de tempo regulares, o jogo verifica a entrada do jogador (a, w, d).
  * Movimento Horizontal (mv_esq, mv_dir): O movimento só é permitido após uma verificação proativa. A função calc_quads determina as coordenadas exatas de todos os blocos da peça, e o sistema checa se as células adjacentes no mapa lógico (cp_mapa) estão livres antes de efetivar o movimento.
  * Rotação (rotate): A rotação também é validada antes de ser aplicada. O sistema simula a próxima rotação, calcula as posições futuras dos blocos e as compara com o cp_mapa. A rotação só é confirmada se não houver nenhuma colisão. Para uma jogabilidade mais fluida, um sistema de "Wall Kick" foi implementado, permitindo que a peça "empurre" as paredes para girar em espaços apertados.
* Renderização do Movimento: A ilusão de movimento é criada pelo par de funções erase_peca e draw_peca, que apagam a peça de sua posição antiga e a redesenham na nova a cada mudança de estado.
### Física, Regras e Pontuação
* Descida e Fixação: A peça desce automaticamente em intervalos de tempo definidos. Quando a descida é bloqueada por outra peça ou pelo chão, um pequeno delay é acionado antes da peça ser permanentemente fixada. Este momento é crucial:
1. O mapa lógico (cp_mapa) é atualizado com as novas posições ocupadas.
2. A flag flag_spawn é ativada, sinalizando que uma nova peça precisa ser gerada.
3. A próxima peça do vetor aleatório é carregada na variável t_peca.
* Limpeza de Linhas e Pontuação: Após cada peça ser fixada, o sistema verifica as linhas correspondentes à sua posição final. Para cada linha completada, a pontuação do jogador é incrementada e um algoritmo é executado para "descer" todas as linhas superiores, preenchendo o espaço vazio de forma eficiente.

<!-- Obrigatório: incluir um VÍDEO DE VOCË explicando o projeto (pode ser somente uma captura de tela...) - Upa o vídeo no youtube ou no drive e poe o link no Readme. ==> Não coloque o Vídeo no Github/Gitlab-->
## Vídeo explicando o programa
https://www.youtube.com/watch?v=_JL-LY9ZFhY&ab_channel=Gabriel

## Colaboradores

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://avatars.githubusercontent.com/u/168935277?v=4" width="100px;" alt="Foto do Bruno no GitHub"/><br>
        <sub>
          <b>Bruno</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="#">
        <img src="https://avatars.githubusercontent.com/u/92697229?v=4" width="100px;" alt="Foto da Icaro no GitHub"/><br>
        <sub>
          <b>Ícaro</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="#">
        <img src="https://avatars.githubusercontent.com/u/114399483?v=4" width="100px;" alt="Foto do Gabriel no GitHub"/><br>
        <sub>
          <b>Gabriel</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="#">
        <img src="https://avatars.githubusercontent.com/u/58113823?v=4" width="100px;" alt="Foto do Natan no GitHub"/><br>
        <sub>
          <b>Natan</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
