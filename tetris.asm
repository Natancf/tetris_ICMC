jmp main

;posicoes
pos     : var #1
pos_ant : var #1

;se 1, spawn
flag_spawn : var #1
static flag_spawn, #1 ;inicializacao

;indice randomico
rand_index : var #1


main:
	call wait_start

	halt

;--------------------------------------------------
;wait_start
;--------------------------------------------------
;espera o jogador apertar ESPACO, enquanto ele nao apertar um contador ficara sendo incrementado
;para coletar um indice aleatorio do vetor randomico
wait_start:
	;salvar os valores de FR, r0 e r1
	push FR
	push r0
	push r1
	push r2

	loadn r0, #699 ;contador
	loadn r1, #' ' ;para verificar se o jogador pressionou start

	loop_count:
		dec r0
		jz reset_count ;caso o contador zere, resetar
		inchar r2
		cmp r1, r2
		jeq end_wait_start
		jmp loop_count

	reset_count:
		loadn r0, #699
		jmp loop_count

	end_wait_start:
		store rand_index, r0 ;salva o indice randomico
		pop r2
		pop r1
		pop r0
		pop FR
		rts
;--------------------------------------------------
;END wait_start
;--------------------------------------------------

;mapa
mapa0  : string "                                        "
mapa1  : string "                                        "
mapa2  : string "                                        "
mapa3  : string "                                        "
mapa4  : string "                                        "
mapa5  : string "                                        "
mapa6  : string "                                        "
mapa7  : string "                                        "
mapa8  : string "                                        "
mapa9  : string "                                        "
mapa10 : string "                                        "
mapa11 : string "                                        "
mapa12 : string "                                        "
mapa13 : string "                                        "
mapa14 : string "                                        "
mapa15 : string "                                        "
mapa16 : string "                                        "
mapa17 : string "                                        "
mapa18 : string "                                        "
mapa19 : string "                                        "
mapa20 : string "                                        "
mapa21 : string "                                        "
mapa22 : string "                                        "
mapa23 : string "                                        "
mapa24 : string "                                        "
mapa25 : string "                                        "
mapa26 : string "                                        "
mapa27 : string "                                        "
mapa28 : string "                                        "
mapa29 : string "                                        "

;vetor randomico





