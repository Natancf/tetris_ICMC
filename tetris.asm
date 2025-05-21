jmp main
;desenhos

; $ = quadrado vazio
; # = quadrado cheio

;mapa do tetris
mapa0  : string "                                        " 
mapa1  : string "                                        " 
mapa2  : string "                                        " 
mapa3  : string "                                        " 
mapa4  : string "                                        " 
mapa5  : string "               $$$$$$$$$$               " 
mapa6  : string "               $$$$$$$$$$               " 
mapa7  : string "               $$$$$$$$$$               " 
mapa8  : string "               $$$$$$$$$$               " 
mapa9  : string "               $$$$$$$$$$               " 
mapa10 : string "               $$$$$$$$$$               " 
mapa11 : string "               $$$$$$$$$$               " 
mapa12 : string "               $$$$$$$$$$               " 
mapa13 : string "               $$$$$$$$$$               " 
mapa14 : string "               $$$$$$$$$$               " 
mapa15 : string "               $$$$$$$$$$               " 
mapa16 : string "               $$$$$$$$$$               " 
mapa17 : string "               $$$$$$$$$$               " 
mapa18 : string "               $$$$$$$$$$               " 
mapa19 : string "               $$$$$$$$$$               " 
mapa20 : string "               $$$$$$$$$$               " 
mapa21 : string "               $$$$$$$$$$               " 
mapa22 : string "               $$$$$$$$$$               " 
mapa23 : string "               $$$$$$$$$$               " 
mapa24 : string "               $$$$$$$$$$               " 
mapa25 : string "                                        " 
mapa26 : string "                                        " 
mapa27 : string "                                        " 
mapa28 : string "                                        " 
mapa29 : string "                                        "

main:
	loadn r0, #220 ;posicao inicial da peca
	loadn r7, #0 ;peca inicial = L
	loadn r6, #0 ;rotacao inicial 0x giro	

	loadn r1, #300 ;contador para descer peca

	call imprime_mapa

	main_loop:
		call desenha_peca
		call delay
		call apaga_L
		call recalc_pos
		dec r1
		cz desce_peca
		jmp main_loop 	
	halt

;----------------------------------------------------------
;Imprime mapa
;----------------------------------------------------------
;parametros
;	NENHUM
imprime_mapa:
	;Tela: 40x30 (largura x altura)
	push r1
	push r5
	push r2
	push r3

	loadn r1, #mapa0 ;primeira linha do mapa
	loadn r5, #0 ;posicao inicial da primeira linha
	loadn r2, #40 ;r2 <- 40
	loadn r3, #1200 ;r3 <- 1200
	loadn r4, #41 ;r4 <- 41
	
	loop_imprime_mapa:
		call imprime_linha
		add r1, r1, r4 ;apontar para a proxima linha do mapa
		add r5, r5, r2 ;apontar para a posicao inicial da proxima linha
		cmp r5, r3 ;verificar se ultrapassou o limite da tela
		jne loop_imprime_mapa
	
	pop r3
	pop r2
	pop r5
	pop r1	
	rts


;----------------------------------------------------------
;Fim imprime_mapa
;---------------------------------------------------------
		
;-----------------------------------------------------------
;Imprime Linha
;-----------------------------------------------------------
;parametros:
;	r1 = endereco inicial da string
;	r5 = posicao inicial da linha
imprime_linha:
	;pushs
	push r1 ;armazena o endereco da string inicial na pilha
	push r2 ;condicao de parada = fim da tela
	push r3 ;armazena char da linha
	push r4 ;contador, se 40, entao para	
	push r5 ;posicao atual da linha

	loadn r2, #40
	loadn r4, #0

	loop_imprime_linha:
		loadi r3, r1 ;Carrega o char
		outchar r3, r5	
		inc r1 ;r1 aponta para o proximo char
		inc r4 ;incrementa o contador
		inc r5 ;incrementa a posicao na linha
		cmp r4, r2 ;verifica condicao de parada se cont = 40
		jne loop_imprime_linha

	;pops
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts
;----------------------------------------------------------
;Fim imprime linha
;----------------------------------------------------------

;----------------------------------------------------------
;desenha_peca
;----------------------------------------------------------
;parametos
;	r0 : posicao da peca
;	r7 : tipo de peca
; 		r7 = 0 L
;		r7 = 1 L invertido
;		r7 = 2 I
;		r7 = 3 quadrado
;		r7 = 4 T
;	r6 : variacoes dos tipos de peca
;		r6 = 0 0x giro horario
;		r6 = 1 1x giro horario
;		r6 = 2 2x giro horario
;		r6 = 3 3x giro horario


desenha_peca:
	;salvando valores dos registradores	
	push r1 ;para verificar o tipo de peca
	
	se_L:
	loadn r1, #0
	cmp r1, r7 ;r0 == 0?
	jne se_Linv ;caso falso

	;caso verdadeiro
	call desenha_L
	jmp fim_desenha_peca

	se_Linv:
	loadn r1, #1
	cmp r1, r7 ; r0 == 1?
	jne se_I ;caso falso

	;caso verdadeiro
	call desenha_Linv
	jmp fim_desenha_peca

	se_I:
	loadn r1, #2
	cmp r1, r7 ; r0 == 2?
	jne se_quad ;caso falso

	;caso verdadeiro
	call desenha_I
	jmp fim_desenha_peca

	se_quad:
	loadn r1, #3
	cmp r1, r7 ; r0 == 3?
	jne se_T ;caso falso

	;caso verdadeiro
	call desenha_quad
	jmp fim_desenha_peca

	se_T:
	call desenha_T
	
	fim_desenha_peca:
		;pops
		pop r1
		rts
;---------------------------------------------------------
;FIM desenha_peca
;---------------------------------------------------------	

;---------------------------------------------------------
;desenha_L
;---------------------------------------------------------
;parametros
;	r0 : posicao da peca
;	r6 : variacao da peca
;		r6 = 0 0x giro horario
;		r6 = 1 1x giro horario
;		r6 = 2 2x giro horario
;		r6 = 3 3x giro horario
desenha_L:
	push r1 ;para verificar a quantidade de giro
	push r2 ;armazena o char de cada quadradinho
	
	;para armazenar as posicoes dos outros quadradinhos	
	push r3
	push r4
	push r5

	loadn r2, #'#'	

	giro_0:
	loadn r1, #0
	cmp r1, r6 ;r6 == 0?
	jne giro_1 ;caso falso

	;caso verdadeiro		
	loadn r3, #40
	add r3, r3, r0 ;r3 = r0 + 40	
	loadn r4, #40
	add r4, r3, r4 ;r4 = r0 + 80	
	mov r5, r4
	inc r5 ;r5 = r0 + 81 

	;OBS: a posicao da peca e o quadrado de cima
	;	r0
	;	X
	;	X X

	giro_1:

	
	outchar r2, r0
	outchar r2, r3
	outchar r2, r4
	outchar r2, r5
	
	;fim desenha_L
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts

;----------------------------------------------------------
;FIM desenha_L
;----------------------------------------------------------

desenha_Linv:
	rts
desenha_I:
	rts
desenha_quad:
	rts
desenha_T:
	rts


;----------------------------------------------------------
;Delay
;----------------------------------------------------------
;parametros
;	NENHUM
delay:
	push r7
	loadn r7, #6400

	delay_loop:
		dec r7
		jnz delay_loop
	
	pop r7
	rts
;----------------------------------------------------------
;FIM Delay
;----------------------------------------------------------

;----------------------------------------------------------
;apaga_L
;----------------------------------------------------------
;parametros
;	r0 : posicao da peca
apaga_L:

	push r1 ;armazena o char

	;posicoes das outras partes
	push r2
	push r3
	push r4

	;valores
	push r5
	loadn r5, #40
	
	;calculo da posicao dos quadradinhos
	add r2, r0, r5 ;r2 = r0 + 40
	add r5, r5, r5 ;r5 = 40 + 40
	add r3, r0, r5 ;r3 = r0 + 80
	inc r5 ;r5 = 81
	add r4, r0, r5
	
	loadn r1, #'$'
	
	outchar r1, r0
	outchar r1, r2
	outchar r1, r3
	outchar r1, r4

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	
	rts
;----------------------------------------------------------
;FIM apaga_L
;----------------------------------------------------------

;----------------------------------------------------------
;recalc_pos
;----------------------------------------------------------
;parametros
;	r0 : posicao da peca
recalc_pos:
	push r1 ;tecla apertada
	push r2 ;esquerda
	push r3 ;direita	

	inchar r1
	
	loadn r2, #'a'
	loadn r3, #'d'

	cmp r1, r2
	ceq mv_esq

	cmp r1, r3
	ceq mv_dir

	pop r3
	pop r2
	pop r1
	rts
;----------------------------------------------------------
;FIM recalc_pos
;----------------------------------------------------------

;----------------------------------------------------------
;mv_esq
;----------------------------------------------------------
;parametros
;	r0 : posicao da peca
mv_esq:
	push r1 ;r1 = 40
	push r2	;r2 usado para verificar qual e a peca
	push r3 ;usado para identificar a borda esquerda

	loadn r1, #40

	;verifica se e L em pe
	loadn r2, #0
	cmp r7, r2 ; Se r7 == 0	
	jeq mv_L_em_pe_esq
	
	mv_L_em_pe_esq:
		loadn r3, #15
		
		mod r1, r0, r1
		cmp r1, r3
		jeq mv_esq_fim
	
		;caso nao esteja na borda do mapa
		dec r0

	mv_esq_fim:
		pop r3
		pop r2
		pop r1
		rts

;----------------------------------------------------------
;FIM mv_esq
;----------------------------------------------------------

;----------------------------------------------------------
;mv_dir
;----------------------------------------------------------
;parametros
;	r0 : posicao da peca
mv_dir:
	push r1 ;r1 = 40
	push r2 ;r2 para verificar qual peca
	push r3 ;usado para identificar a borda direita

	loadn r1, #40	

	;verifica se e L em pe
	loadn r2, #0
	cmp r7, r2
	jeq mv_L_em_pe_dir
	
	mv_L_em_pe_dir:
	push r0 ;calcular a posicao da ponta do L
	;r0
	;r2
	;r3 ;r4
	
	;r0 = 81
	add r0, r0, r1 ; r0 += 40
	add r0, r0, r1 ; r0 += 40, 
	inc r0 ; r0++

	loadn r3, #24
	mod r1, r0, r1
	
	pop r0 ;recupera o valor original da posicao

	cmp r1, r3
	jeq mv_dir_fim

	;caso nao esteja na borda direita
	inc r0

	mv_dir_fim:
		pop r3
		pop r2
		pop r1
		rts
;----------------------------------------------------------
;FIM mv_dir
;----------------------------------------------------------

;----------------------------------------------------------
;mv_baixo
;----------------------------------------------------------
;parametros
;	r0 : posicao da peca
mv_baixo:
	push r2 ;r2 para verificar qual peca
	push r3 ;usado para identificar a borda de baixo
	push r5 ;aux
	push r4 ;usado para calcular outros quadradinhos das pecas

	;verifica se e L em pe
	loadn r2, #0
	cmp r7, r2
	jeq mv_L_em_pe_baixo
	
	mv_L_em_pe_baixo:
		;A
		;B
		;C ;D
		
		;calcular a posicao de C
		;r4 = r0 + 80, ou seja r4 = C
		loadn r5, #40
		add r4, r0, r5 ; r4 = r0 + 40
		add r4, r4, r5 ; r4 += 40 
		
		loadn r5, #975
		
		;verifica se e maior que 975
		cmp r4, r5
		jeg mv_baixo_fim	

	;caso nao esteja na borda de baixo
	loadn r5, #40
	add r0, r0, r5 ;r0 += 40 para descer

	mv_baixo_fim:
		pop r4
		pop r5	
		pop r3
		pop r2
		rts
;----------------------------------------------------------
;FIM mv_baixo
;----------------------------------------------------------

;----------------------------------------------------------
;desce_peca
;----------------------------------------------------------
;parametros
;	r0 : posicao da peca
desce_peca:
	loadn r1, #300
	call mv_baixo
	rts
;---------------------------------------------------------
;FIM desce_peca
;---------------------------------------------------------

