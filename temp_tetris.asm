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

quads : var #4 ;variavel de retorno do calculo dos quadradinhos de determinada peca
atual_rot_I : var #1 ;para armazenar qual rotacao a peca I esta
quads_ocupados : var #200 ;quais quadrados da grade estao ocupados, onde se 1 entao ocupado e 0 caso contrario
;fazer busca binaria para procurar o elemento

pos : var #1
pos_ant : var #1
t_peca : var #1

static pos, #220 ;posicao inicial da peca
static pos_ant, #220 ;posicao inicial da peca
static t_peca, #4 ;peca inicial
; t_peca
;	0-3 L
;	4-7 Linv
;	8-9 I
;	10 quad
;	11-14 T

static atual_rot_I + #0, #0

main:
	loadn r1, #300 ;contador para descer peca
	
	call imprime_mapa

	main_loop:
		call desenha_peca
		call delay
		call apaga_peca
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
	push r2
	push r3
	push r6
	push r7

	loadn r3, #1200 ;condicao de parada do loop

	loadn r7, #0 ;posicao inicial
	loadn r1, #40 ;para pular para a proxima linha

	loadn r6, #mapa0 ;endereco inicial do mapa
	loadn r2, #41    ;para pular para a proxima string do mapa, pois string adiciona \0 ao final entao 40 + 1
	
	imprime_mapa_loop:
		call imprime_linha
		add r7, r7, r1 ;r7 aponta para a proxima linha da tela
		cmp r7, r3 ;verifica se chegou ao fim da tela
		jeq imprime_mapa_loop_sai
		add r6, r6, r2 ;r6 aponta para a proxima string do mapa
		jmp imprime_mapa_loop		


	imprime_mapa_loop_sai:
		pop r7
		pop r6
		pop r3
		pop r2
		pop r1
		rts
;----------------------------------------------------------
;Fim imprime_mapa
;---------------------------------------------------------
		
;-----------------------------------------------------------
;Imprime Linha
;-----------------------------------------------------------
;parametros:
;	r6 = endereco inicial da string
;	r7 = posicao inicial da linha
imprime_linha:
	push r1
	push r2
	push r6
	push r7

	loadn r1, #'\0' ;condicao de parada
	

	imprime_linha_loop:
		loadi r2, r6
		cmp r2, r1
		jeq imprime_linha_sai_loop
		outchar r2, r7 
		inc r6
		inc r7 
		jmp imprime_linha_loop


	imprime_linha_sai_loop:
		pop r7
		pop r6
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
;	pos    : posicao da peca
;	t_peca : tipo de peca
desenha_peca:
	push r5
	loadn r5, #'#'
	call des_apag_peca
	pop r5
	rts
;--------------------------------------------------------------------------------------------
;FIM desenha_peca
;--------------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------------
;apaga_peca
;--------------------------------------------------------------------------------------------
;parametros
;	pos    : posicao da peca
;	t_peca : tipo de peca
apaga_peca:
	push r5
	loadn r5, #'$'
	call des_apag_peca
	pop r5
	rts
;--------------------------------------------------------------------------------------------
;FIM apaga_peca
;--------------------------------------------------------------------------------------------

;---------------------------------------------------------
;des_apag_peca
;---------------------------------------------------------
;parametros:
;	pos    : posicao da peca
;	r5     : # (desenha) ou $ (apaga)
;	t_peca : tipo da peca
des_apag_peca:
	;para coletar as posicoes dos quadradinhos
	push r0
	push r1
	push r2
	push r3	

	load r0, pos

	push r4 ;endereco de memoria das posicoes dos quadradinhos

	call calc_quads	

	loadn r4, #quads
	inc r4
	loadi r1, r4
	inc r4
	loadi r2, r4
	inc r4
	loadi r3, r4		

	outchar r5, r0
	outchar r5, r1
	outchar r5, r2
	outchar r5, r3

	;pops
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;---------------------------------------------------------
;FIM desenha_peca
;---------------------------------------------------------	

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
;-----------------------------------------------
;FIM Delay
;----------------------------------------------------------

;----------------------------------------------------------
;recalc_pos
;----------------------------------------------------------
;parametros
;	pos : posicao da peca
recalc_pos:
	push r1 ;tecla apertada
	push r2 ;esquerda
	push r3 ;direita	
	push r4 ;cima (rotacionar)

	inchar r1
	
	loadn r2, #'a'
	loadn r3, #'d'
	loadn r4, #'w'

	cmp r1, r2
	ceq mv_esq

	cmp r1, r3
	ceq mv_dir

	cmp r1, r4
	ceq rotacionar

	pop r4
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
;	pos : posicao da peca
mv_esq:
	push r0 ;posicao da peca
	push r1 ;auxiliar
	push r2 ;40
	push r3 ;15
	push r4 ;vetor de quads 

	load r0, pos

	loadn r2, #40
	loadn r3, #15


	call calc_quads ;calcula a posicao de cada quadradinho
	loadn r4, #quads ;r4 aponta para o vetor dos quadradinhos

	;verificar se A esta na borda
	mov r1, r0
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_esq

	;B
	inc r4
	loadi r1, r4
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_esq

	;C
	inc r4
	loadi r1, r4
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_esq

	;D
	inc r4
	loadi r1, r4
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_esq	

	dec r0

	fim_mv_esq:
	;atualizar posicao
	store pos, r0


	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;----------------------------------------------------------
;FIM mv_esq
;----------------------------------------------------------

;----------------------------------------------------------
;mv_dir
;----------------------------------------------------------
;parametros
;	pos : posicao da peca
mv_dir:
	push r0 ; posicao da peca
	push r1 ;auxiliar
	push r2 ;40
	push r3 ;15
	push r4 ;vetor de quads 

	load r0, pos

	loadn r2, #40
	loadn r3, #24


	call calc_quads ;calcula a posicao de cada quadradinho
	loadn r4, #quads ;r4 aponta para o vetor dos quadradinhos

	;verificar se A esta na borda
	mov r1, r0
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_dir

	;B
	inc r4
	loadi r1, r4
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_dir

	;C
	inc r4
	loadi r1, r4
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_dir

	;D
	inc r4
	loadi r1, r4
	mod r1, r1, r2
	cmp r1, r3
	jeq fim_mv_dir	

	inc r0

	fim_mv_dir:
	;atualizar posicao
	store pos, r0

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;----------------------------------------------------------
;FIM mv_dir
;----------------------------------------------------------

;----------------------------------------------------------
;mv_baixo
;----------------------------------------------------------
;parametros
;	pos : posicao da peca
mv_baixo:
	push r0 ;posicao da peca
	push r2 ;r2 para verificar qual peca
	push r3 ;usado para identificar a borda de baixo
	push r5 ;aux
	push r4 ;usado para calcular outros quadradinhos das pecas
	
	load r0, pos

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
		;atualizar posicao
		store pos, r0


		pop r4
		pop r5	
		pop r3
		pop r2
		pop r0
		rts
;----------------------------------------------------------
;FIM mv_baixo
;----------------------------------------------------------

;----------------------------------------------------------
;desce_peca
;----------------------------------------------------------
;parametros
;	pos : posicao da peca
;	r1 : contador do delay para descer peca
desce_peca:
	loadn r1, #300
	call mv_baixo
	rts
;---------------------------------------------------------
;FIM desce_peca
;--------------------------------------------------------
;---------------------------------------------------------
;calc_quads
;---------------------------------------------------------
;calcula os quadradinhos de cada peca
;parametros:
;	- pos    : posicao da peca
;	- t_peca : tipo de peca
;retorno
;	variaveis na memoria
;	quads[0] <- A	
;	quads[1] <- B
;	quads[2] <- C
;	quads[3] <- D
;	OBS: r0 = A

calc_quads:
	push r0 ;posicao
	push r7 ;tipo de peca
	push r1 ;auxiliar 
	push r2 ;para verificar o tipo de peca e enderecar a memoria
	push r3 ;40

	load r0, pos
	load r7, t_peca

	loadn r3, #40

	verifica_se_L:
		loadn r2, #3
		cmp r7, r2
		jel if_L

	verifica_se_linv:
		loadn r2, #7
		cmp r7, r2
		jel if_Linv

	verifica_se_I:
		loadn r2, #9
		cmp r7, r2
		jel if_I
	
	verifica_se_quad:
		loadn r2, #10
		cmp r7, r2
		jeq if_quad

	;Peca T-------------------------------------------------------
	loadn r2, #quads ;r2 <- endereco de quads_L

	;rot_T_0
		loadn r1, #11
		cmp r1, r7 ;r7 == 11?
		jne rot_T_1 ;caso falso

		;caso verdadeiro
		;B = A - 1
		mov r1, r0
		dec r1
		inc r2
		storei r2, r1

		;C = A + 1
		mov r1, r0
		inc r1
		inc r2
		storei r2, r1

		;D = A - 40
		mov r1, r0
		sub r1, r1, r3
		inc r2
		storei r2, r1		
	
		;OBS:
		;	  D
		;	B A C 

		jmp fim_calc_quads

		rot_T_1:
		loadn r1, #12
		cmp r1, r7 ;r7 == 12?
		jne rot_T_2 ;caso falso

		;caso verdadeiro
		;B = A - 40
		mov r1, r0
		sub r1, r1, r3
		inc r2
		storei r2, r1

		;C = A + 40
		mov r1, r0
		add r1, r1, r3
		inc r2
		storei r2, r1
			
		;D = A + 1
		mov r1, r0
		inc r1
		inc r2
		storei r2, r1
			
		;OBS:
		;	B
		;	A D
		;	C

		jmp fim_calc_quads

		rot_T_2:
		loadn r1, #13
		cmp r1, r7 ;r7 == 13?
		jne rot_T_3 ;caso falso

		;caso verdadeiro
		;B = A + 1
		mov r1, r0
		inc r1
		inc r2
		storei r2, r1

		;C = A - 1
		mov r1, r0
		dec r1
		inc r2
		storei r2, r1


		;D = A + 40
		mov r1, r0
		add r1, r1, r3
		inc r2
		storei r2, r1

		;OBS:
		;	C A B
		;	  D

		jmp fim_calc_quads

		rot_T_3:
		;B = A + 40
		mov r1, r0
		add r1, r1, r3
		inc r2
		storei r2, r1		
	
		;C = A - 40
		mov r1, r0
		sub r1, r1, r3
		inc r2
		storei r2, r1
	
		;D = A - 1
		mov r1, r0
		dec r1
		inc r2
		storei r2, r1

		;OBS:
		;	  C
		;	D A
		;	  B

		jmp fim_calc_quads
	;FIM peca T---------------------------------------------------
	;Peca L ------------------------------------------------------
	if_L:
		loadn r2, #quads ;r2 <- endereco de quads_L
		
		;rot_L_0
			loadn r1, #0
			cmp r1, r7; r7 == 0?
			jne rot_L_1 ;caso falso

			;caso verdadeiro
			;B = A - 1
			mov r1, r0
			dec r1
			inc r2
			storei r2, r1 ;B = quads_L[1] = r1
			
			;C = A + 1
			mov r1, r0
			inc r1
			inc r2
			storei r2, r1 ;C = quads_L[2] = r1

			;D = A + 1 - 40
			sub r1, r1, r3
			inc r2
			storei r2, r1 ;D = quads_L[3] = r1

			;OBS:
			;	    D
			;	B A C
			jmp fim_calc_quads

		rot_L_1:
			loadn r1, #1
			cmp r1, r7; r7 == 1?
			jne rot_L_2 ;caso falso

			;caso verdadeiro
			;B = A - 40
			loadn r1, #40
			sub r1, r0, r1
			inc r2
			storei r2, r1 ;B = quads_L[1] = r1

			;C = A + 40
			loadn r1, #40
			add r1, r0, r1
			inc r2
			storei r2, r1 ;C = quads_L[2] = r1

			;D = A + 40 + 1
			inc r1
			inc r2
			storei r2, r1 ;C = quads_L[3] = r1

			;OBS:
			;	B
			;	A
			;	C D
			jmp fim_calc_quads

		rot_L_2:
			loadn r1, #2
			cmp r1, r7 ;r7 == 2
			jne rot_L_3 ;caso falso
		
			;caso verdadeiro
			;B = A + 1
			mov r1, r0
			inc r1
			inc r2
			storei r2, r1


			;C = A - 1
			mov r1, r0
			dec r1
			inc r2
			storei r2, r1			

			;D = A - 1 + 40
			add r1, r3, r1
			inc r2
			storei r2, r1

			;OBS:
			;	C A B
			;	D 
	
			jmp fim_calc_quads

		rot_L_3:
			;B = A + 40
			mov r1, r0
			add r1, r0, r3
			inc r2
			storei r2, r1			

			;C = A - 40
			mov r1, r0
			sub r1, r1, r3
			inc r2
			storei r2, r1			
		
			;D = A - 40 - 1
			dec r1
			inc r2
			storei r2, r1			
		
			;OBS:
			;     D	C	
			;	A
			;       B
			jmp fim_calc_quads
		
	;FIM Peca L------------------------------------------------------
	
	;Peca Linv-------------------------------------------------------
	if_Linv:
		loadn r2, #quads 
		
		;rot_Linv_0
			loadn r1, #4
			cmp r1, r7 ;r7 == 4?
			jne rot_Linv_1 ;caso falso
			
			;caso verdadeiro
			;B = A + 1
			mov r1, r0
			inc r1
			inc r2
			storei r2, r1

			;C = A - 1
			dec r1
			dec r1
			inc r2
			storei r2, r1

			;D = A - 1 - 40
			sub r1, r1, r3
			inc r2
			storei r2, r1		

			;OBS:
			;	D
			;	C A B

			jmp fim_calc_quads
		
		rot_Linv_1:
			loadn r1, #5
			cmp r1, r7 ;r7 == 5?
			jne rot_Linv_2 ;caso falso

			;caso verdadeiro			
			;B = A + 40
			mov r1, r0
			add r1, r1, r3
			inc r2
			storei r2, r1

			;C = A - 40
			mov r1, r0
			sub r1, r1, r3
			inc r2
			storei r2, r1

			;D = A - 40 + 1
			inc r1
			inc r2
			storei r2, r1			

			;OBS:
			;	C D
			;	A
			;	B

			jmp fim_calc_quads

		rot_Linv_2: 
			loadn r1, #6
			cmp r1, r7 ;r7 == 6?
			jne rot_Linv_3 ;caso falso

			;caso verdadeiro
			;B = A - 1
			mov r1, r0
			dec r1
			inc r2
			storei r2, r1
	
			;C = A + 1
			mov r1, r0
			inc r1
			inc r2
			storei r2, r1

			;D = A + 1 + 40
			add r1, r1, r3
			inc r2
			storei r2, r1		
	
			;OBS:
			;	B A C
			;	    D
	
			jmp fim_calc_quads

		rot_Linv_3:
			;B = A - 40
			mov r1, r0
			sub r1, r1, r3
			inc r2
			storei r2, r1

			;C = A + 40
			mov r1, r0
			add r1, r1, r3
			inc r2
			storei r2, r1

			;D = A + 40 - 1
			dec r1
			inc r2
			storei r2, r1

			;OBS:
			;	  B
			;	  A
			;	D C
	
			jmp fim_calc_quads

	;FIM Peca Linv---------------------------------------------------
	;Peca I----------------------------------------------------------
	if_I:
		loadn r2, #quads	
		
		;rot_I_0
			loadn r1, #8
			cmp r1, r7 ;r7 == 8?
			jne rot_I_1 ;caso falso

			;caso verdadeiro
			;B = A - 1
			mov r1, r0
			dec r1
			inc r2
			storei r2, r1

			;C = A + 1
			mov r1, r0
			inc r1
			inc r2
			storei r2, r1
	
			;D = A + 2
			inc r1
			inc r2
			storei r2, r1

			;OBS:
			;	B A C D
	
			jmp fim_calc_quads

		rot_I_1:
			;B = A - 40
			mov r1, r0
			sub r1, r1, r3
			inc r2
			storei r2, r1	
	
			;C = A + 40
			mov r1, r0
			add r1, r1, r3
			inc r2
			storei r2, r1

			;D = A + 40 + 40
			add r1, r1, r3
			inc r2
			storei r2, r1
						
			;OBS:
			;	B
			;	A
			;       C
			;       D 

			jmp fim_calc_quads	
	;FIM peca I-----------------------------------------------------	

	;peca quad------------------------------------------------------
	if_quad:
		;B = A + 1
		loadn r2, #quads
		mov r1, r0
		inc r1
		inc r2
		storei r2, r1

		;D = A + 1 + 40
		add r1, r1, r3
		inc r2
		storei r2, r1
		

		;C = A + 1 + 40 - 1
		dec r1
		inc r2
		storei r2, r1

		;OBS:
		;	A B
		;	C D 
		

	;FIM peca quad--------------------------------------------------

	fim_calc_quads:
	pop r3
	pop r2
	pop r1
	pop r7
	pop r0
	rts

;---------------------------------------------------------
;FIM calc_quads
;---------------------------------------------------------

;--------------------------------------------------------------------------------------------
;rotacionar
;--------------------------------------------------------------------------------------------
;parametros
;	- pos    : posicao da peca
;	- t_peca : tipo de peca
rotacionar:
	push r0 ;posicao
	push r1 ;auxiliar
	push r2	;40
	push r3	;15
	push r4 ;24
	push r5 ;auxiliar
	push r6 ;auxiliar
	push r7 ;tipo de peca

	;carregar posicao e tipo
	load r0, pos
	load r7, t_peca	


	;para verificar se a peca esta na borda
	loadn r2, #40
	loadn r3, #15
	loadn r4, #24

	;verificar se L
	loadn r1, #3
	cmp r7, r1
	jel se_L_rotacionar

	;verificar se Linv
	loadn r1, #7
	cmp r7, r1
	jel se_Linv_rotacionar

	;verificar se I
	loadn r1, #9
	cmp r7, r1
	jel se_I_rotacionar

	;verificar se T
	loadn r1, #11
	cmp r7, r1
	jeg se_T_rotacionar


	jmp fim_rotacionar 

	se_L_rotacionar:
		;verifica se L esta na ultima rotacao
		cmp r7, r1
		jeq L_rotacao_reset
		
		;caso contrario
		inc r7		
		jmp se_L_borda

		L_rotacao_reset:
			loadn r7, #0	

		se_L_borda: ;verificar se L esta na borda
			;se esta na borda esquerda
			mod r1, r0, r2
			cmp r1, r3
			jne se_L_borda_dir

			;caso esteja na borda esquerda
			inc r0
			jmp fim_rotacionar

			se_L_borda_dir:
			cmp r1, r4
			jne fim_rotacionar
			
			;caso esteja na borda direita
			dec r0
			jmp fim_rotacionar

	se_Linv_rotacionar:
		;verifica se Linv esta na ultima rotacao
		cmp r7, r1
		jeq Linv_rotacao_reset

		;caso contrario
		inc r7
		jmp se_Linv_borda
	
		Linv_rotacao_reset:
			loadn r7, #4	

		se_Linv_borda:
			mod r1, r0, r2 ; r1 = pos mod 40
			cmp r1, r3 ; r1 == 15?
			jne se_Linv_borda_dir ;caso falso
		
			;caso verdadeiro
			inc r0
			jmp fim_rotacionar

			se_Linv_borda_dir:
				cmp r1, r4 ;r1 == 24?
				jne fim_rotacionar ;caso falso
				
				;caso verdadeiro
				dec r0
				jmp fim_rotacionar

	se_I_rotacionar:
		loadn r6, #atual_rot_I
		loadi r5, r6 ;r5 = rotacao atual de I

		;se_I_rotacao_0
		loadn r1, #0
		cmp r1, r5 
		jne se_I_rotacao_1 ;caso falso 

		;caso verdadeiro
		inc r0
		inc r7
		inc r1
		storei r6, r1
		jmp fim_rotacionar

		;OBS:
		;
		;	B A C D
		;
		;

		se_I_rotacao_1:
		loadn r1, #1
		cmp r1, r5
		jne se_I_rotacao_2 ;caso falso

		;caso verdadeiro
		;verificar se esta na borda do mapa
		mod r1, r0, r2
		cmp r1, r3 ;verificar se esta na borda esquerda
		jne se_I_rot_1_bdir ;caso r0 nao esteja na borda esquerda

		;caso esteja
		inc r0
		inc r0
		jmp fim_I_rotacao_1

		se_I_rot_1_bdir: ;verificar se r0 esta na borda direita
		cmp r1, r4
		jne fim_I_rotacao_1 ;caso r0 nao esteja na borda direita

		;caso esteja
		dec r0
	
		fim_I_rotacao_1:	
			dec r0
			add r0, r0, r2
			dec r7
			loadn r1, #2
			storei r6, r1
			jmp fim_rotacionar
	
		;OBS:
		;	    B
		;	    A
		;	    C
		;	    D


		se_I_rotacao_2:
		loadn r1, #2
		cmp r1, r5
		jne se_I_rotacao_3 ;caso falso
		
		;caso verdadeiro
		sub r0, r0, r2
		inc r7
		inc r1
		storei r6, r1
		jmp fim_rotacionar

		;OBS:
		;	  
		;	  
		;	B A C D  
		;	  

		se_I_rotacao_3:
		;caso verdadeiro
		;verificar se esta na borda esquerda do mapa
		mod r1, r0, r2
		cmp r1, r3 
		jne se_I_rot_3_bdir ;verificar se esta na borda direita

		;caso esteja na borda esquerda
		inc r0
		jmp fim_I_rotacao_3		
		
		se_I_rot_3_bdir:
		cmp r1, r4
		jne fim_I_rotacao_3 ;caso nao esteja na borda direita
		
		;caso esteja na borda direita
		dec r0
		dec r0		

		fim_I_rotacao_3:
			;mantem r0
			dec r7
			loadn r1, #0
			storei r6, r1

		;OBS:
		;	  B
		;	  A
		;	  C
		;	  D

		jmp fim_rotacionar

	se_T_rotacionar:
		;verifica se T esta na ultima rotacao
		inc r1
		inc r1
		inc r1
		cmp r7, r1
		jeq T_rotacao_reset

		;caso contrario
		inc r7
		jmp se_T_borda
	
		T_rotacao_reset:
			loadn r7, #11

		se_T_borda:
			mod r1, r0, r2 ; r1 = pos mod 40
			cmp r1, r3 ; r1 == 15?
			jne se_T_borda_dir ;caso falso
		
			;caso verdadeiro
			inc r0
			jmp fim_rotacionar

			se_T_borda_dir:
				cmp r1, r4 ;r1 == 24?
				jne fim_rotacionar ;caso falso
				
				;caso verdadeiro
				dec r0
				jmp fim_rotacionar




	fim_rotacionar:
		;atualizar posicao e tipo de peca
		store pos, r0
		store t_peca, r7

		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

;--------------------------------------------------------------------------------------------
;FIM rotacionr
;--------------------------------------------------------------------------------------------

