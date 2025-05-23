jmp main

;posicoes-------------------------------------------------------------
pos            : var #1
pos_ant        : var #1
pos_calc_quads : var #1 ;parametro da funcao calc_quads
;posicoes dos outros quadradinhos
quads : var #4 ;o primeiro elemento do vetor esta inutilizado, mas manter, pois caso contrario
;calc_quads nao funciona

;tipo de peca e rotacao atual-----------------------------------------
t_peca : var #1
; 0-3 L
; 4-7 Linv
; 8-9 I
; 10 quadrado
; 11-14 T
; 15-18 Z
; 19-22 S

;se 1, spawn---------------------------------------------------------
flag_spawn : var #1
static flag_spawn, #1 ;inicializacao

;indice randomico-----------------------------------------------------
rand_index : var #1

;mensagem inicial----------------------------------------------------
msg_inicial : string "     Pressione ESPACO para INICIAR!     "                                        
apaga_msg   : string "                                        "

main:
	;Impressao da mensagem inicial
	loadn r0, #560
	loadn r1, #msg_inicial
	call print_string
	
	call wait_start

	;Apaga mensagem inicial
	loadn r1, #apaga_msg
	call print_string

	call draw_map

	halt

;--------------------------------------------------
;print_string
;--------------------------------------------------
;parametros
;	r0 : posicao inicial da linha (0, 40, 80, 120, 160...)
;	r1 : endereco inicial da string
print_string:
	push FR
	push r0 ;posicao inicial da linha
	push r1 ;endereco incial da string
	push r2 ;40
	push r3 ;\0
	push r4 ;char

	loadn r2, #40
	loadn r3, #'\0'

	loop_print_string:
		loadi r4, r1 ;carrega cada char da string em r4
		cmp r4, r3 ;verifica se chegou no final da string
		jeq end_print_string
		outchar r4, r0
		inc r1 ;ir ao proximo char
		inc r0 ;ir a proxima posicao
		jmp loop_print_string
		

	end_print_string:
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		pop FR
		rts

;--------------------------------------------------
;END print_string
;--------------------------------------------------

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

;--------------------------------------------------
;start_game
;-------------------------------------------------
;desenha o mapa e
;inicializa o tipo de peca 
start_game:
	push FR
	push r0 
	push r1 
	push r2 

	;desenha_mapa
	

	;inicializa t_peca
	load r0, rand_index
	loadn r1, #rand
	add r1, r1, r0 ;r1 aponta para rand[r0]
	loadi r2, r1
	store t_peca, r2

	pop r2
	pop r1
	pop r0
	pop FR
	rts
	
;--------------------------------------------------
;END start_game
;--------------------------------------------------

;--------------------------------------------------
;draw_map
;--------------------------------------------------
draw_map:
        ;Tela: 40x30 (largura x altura)
	push FR
        push r0
        push r1
        push r2
        push r3
        push r4

        loadn r3, #1200 ;condicao de parada do loop

        loadn r0, #0 ;posicao inicial
        loadn r2, #40 ;para pular para a proxima linha

        loadn r1, #mapa0 ;endereco inicial do mapa
        loadn r4, #41    ;para pular para a proxima string do mapa, pois string adiciona \0 ao final entao 40 + 1

        draw_map_loop:
                call print_string
                add r0, r0, r2 ;r0 aponta para a proxima linha da tela
                cmp r0, r3 ;verifica se chegou ao fim da tela
                jeq exit_draw_map_loop
                add r1, r1, r4 ;r6 aponta para a proxima string do mapa
                jmp draw_map_loop


        exit_draw_map_loop:
                pop r4
                pop r3
                pop r2
                pop r1
                pop r0
		pop FR
                rts

;--------------------------------------------------
;END draw_map
;--------------------------------------------------

;mapa
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

;vetor randomico (contem valores aleatorios de 0 a 6)
rand : var #700
static rand + #0, #4
static rand + #1, #4
static rand + #2, #10
static rand + #3, #4
static rand + #4, #4
static rand + #5, #8
static rand + #6, #10
static rand + #7, #11
static rand + #8, #11
static rand + #9, #11
static rand + #10, #0
static rand + #11, #11
static rand + #12, #15
static rand + #13, #11
static rand + #14, #15
static rand + #15, #4
static rand + #16, #4
static rand + #17, #11
static rand + #18, #15
static rand + #19, #11
static rand + #20, #4
static rand + #21, #0
static rand + #22, #0
static rand + #23, #11
static rand + #24, #10
static rand + #25, #0
static rand + #26, #15
static rand + #27, #0
static rand + #28, #19
static rand + #29, #19
static rand + #30, #19
static rand + #31, #15
static rand + #32, #0
static rand + #33, #10
static rand + #34, #0
static rand + #35, #8
static rand + #36, #11
static rand + #37, #0
static rand + #38, #19
static rand + #39, #15
static rand + #40, #8
static rand + #41, #8
static rand + #42, #11
static rand + #43, #15
static rand + #44, #8
static rand + #45, #4
static rand + #46, #19
static rand + #47, #15
static rand + #48, #0
static rand + #49, #8
static rand + #50, #11
static rand + #51, #19
static rand + #52, #11
static rand + #53, #10
static rand + #54, #0
static rand + #55, #19
static rand + #56, #19
static rand + #57, #4
static rand + #58, #10
static rand + #59, #19
static rand + #60, #4
static rand + #61, #11
static rand + #62, #4
static rand + #63, #19
static rand + #64, #19
static rand + #65, #11
static rand + #66, #11
static rand + #67, #15
static rand + #68, #19
static rand + #69, #15
static rand + #70, #8
static rand + #71, #10
static rand + #72, #15
static rand + #73, #4
static rand + #74, #4
static rand + #75, #8
static rand + #76, #19
static rand + #77, #8
static rand + #78, #10
static rand + #79, #10
static rand + #80, #10
static rand + #81, #19
static rand + #82, #11
static rand + #83, #8
static rand + #84, #4
static rand + #85, #8
static rand + #86, #8
static rand + #87, #8
static rand + #88, #15
static rand + #89, #8
static rand + #90, #0
static rand + #91, #19
static rand + #92, #10
static rand + #93, #8
static rand + #94, #8
static rand + #95, #4
static rand + #96, #10
static rand + #97, #10
static rand + #98, #15
static rand + #99, #4
static rand + #100, #15
static rand + #101, #15
static rand + #102, #8
static rand + #103, #11
static rand + #104, #8
static rand + #105, #11
static rand + #106, #8
static rand + #107, #11
static rand + #108, #15
static rand + #109, #8
static rand + #110, #15
static rand + #111, #19
static rand + #112, #15
static rand + #113, #19
static rand + #114, #15
static rand + #115, #10
static rand + #116, #4
static rand + #117, #8
static rand + #118, #10
static rand + #119, #11
static rand + #120, #15
static rand + #121, #10
static rand + #122, #15
static rand + #123, #0
static rand + #124, #0
static rand + #125, #11
static rand + #126, #8
static rand + #127, #11
static rand + #128, #15
static rand + #129, #15
static rand + #130, #4
static rand + #131, #10
static rand + #132, #8
static rand + #133, #0
static rand + #134, #0
static rand + #135, #19
static rand + #136, #0
static rand + #137, #0
static rand + #138, #0
static rand + #139, #8
static rand + #140, #11
static rand + #141, #11
static rand + #142, #11
static rand + #143, #19
static rand + #144, #15
static rand + #145, #8
static rand + #146, #10
static rand + #147, #8
static rand + #148, #15
static rand + #149, #8
static rand + #150, #19
static rand + #151, #19
static rand + #152, #19
static rand + #153, #19
static rand + #154, #10
static rand + #155, #11
static rand + #156, #15
static rand + #157, #0
static rand + #158, #11
static rand + #159, #8
static rand + #160, #10
static rand + #161, #8
static rand + #162, #11
static rand + #163, #10
static rand + #164, #11
static rand + #165, #19
static rand + #166, #8
static rand + #167, #0
static rand + #168, #19
static rand + #169, #10
static rand + #170, #8
static rand + #171, #19
static rand + #172, #10
static rand + #173, #8
static rand + #174, #4
static rand + #175, #10
static rand + #176, #11
static rand + #177, #10
static rand + #178, #10
static rand + #179, #10
static rand + #180, #10
static rand + #181, #15
static rand + #182, #0
static rand + #183, #10
static rand + #184, #15
static rand + #185, #10
static rand + #186, #10
static rand + #187, #4
static rand + #188, #8
static rand + #189, #0
static rand + #190, #19
static rand + #191, #19
static rand + #192, #4
static rand + #193, #10
static rand + #194, #0
static rand + #195, #11
static rand + #196, #10
static rand + #197, #8
static rand + #198, #11
static rand + #199, #19
static rand + #200, #11
static rand + #201, #8
static rand + #202, #11
static rand + #203, #0
static rand + #204, #10
static rand + #205, #11
static rand + #206, #11
static rand + #207, #4
static rand + #208, #8
static rand + #209, #0
static rand + #210, #11
static rand + #211, #4
static rand + #212, #4
static rand + #213, #8
static rand + #214, #19
static rand + #215, #15
static rand + #216, #11
static rand + #217, #19
static rand + #218, #4
static rand + #219, #15
static rand + #220, #4
static rand + #221, #8
static rand + #222, #19
static rand + #223, #19
static rand + #224, #11
static rand + #225, #8
static rand + #226, #10
static rand + #227, #4
static rand + #228, #15
static rand + #229, #11
static rand + #230, #11
static rand + #231, #4
static rand + #232, #0
static rand + #233, #10
static rand + #234, #15
static rand + #235, #10
static rand + #236, #4
static rand + #237, #0
static rand + #238, #0
static rand + #239, #10
static rand + #240, #4
static rand + #241, #8
static rand + #242, #15
static rand + #243, #4
static rand + #244, #4
static rand + #245, #0
static rand + #246, #8
static rand + #247, #4
static rand + #248, #19
static rand + #249, #10
static rand + #250, #4
static rand + #251, #8
static rand + #252, #8
static rand + #253, #19
static rand + #254, #0
static rand + #255, #10
static rand + #256, #8
static rand + #257, #8
static rand + #258, #0
static rand + #259, #15
static rand + #260, #8
static rand + #261, #15
static rand + #262, #8
static rand + #263, #8
static rand + #264, #8
static rand + #265, #0
static rand + #266, #15
static rand + #267, #15
static rand + #268, #11
static rand + #269, #10
static rand + #270, #15
static rand + #271, #8
static rand + #272, #8
static rand + #273, #10
static rand + #274, #10
static rand + #275, #11
static rand + #276, #4
static rand + #277, #0
static rand + #278, #11
static rand + #279, #0
static rand + #280, #8
static rand + #281, #11
static rand + #282, #4
static rand + #283, #15
static rand + #284, #0
static rand + #285, #15
static rand + #286, #4
static rand + #287, #0
static rand + #288, #0
static rand + #289, #10
static rand + #290, #11
static rand + #291, #10
static rand + #292, #11
static rand + #293, #0
static rand + #294, #10
static rand + #295, #8
static rand + #296, #19
static rand + #297, #0
static rand + #298, #11
static rand + #299, #10
static rand + #300, #10
static rand + #301, #19
static rand + #302, #15
static rand + #303, #15
static rand + #304, #4
static rand + #305, #0
static rand + #306, #15
static rand + #307, #4
static rand + #308, #11
static rand + #309, #8
static rand + #310, #8
static rand + #311, #19
static rand + #312, #11
static rand + #313, #19
static rand + #314, #10
static rand + #315, #11
static rand + #316, #11
static rand + #317, #0
static rand + #318, #4
static rand + #319, #4
static rand + #320, #15
static rand + #321, #0
static rand + #322, #10
static rand + #323, #19
static rand + #324, #10
static rand + #325, #8
static rand + #326, #19
static rand + #327, #4
static rand + #328, #4
static rand + #329, #4
static rand + #330, #19
static rand + #331, #10
static rand + #332, #11
static rand + #333, #4
static rand + #334, #10
static rand + #335, #15
static rand + #336, #8
static rand + #337, #10
static rand + #338, #4
static rand + #339, #4
static rand + #340, #10
static rand + #341, #15
static rand + #342, #8
static rand + #343, #15
static rand + #344, #10
static rand + #345, #0
static rand + #346, #11
static rand + #347, #8
static rand + #348, #15
static rand + #349, #4
static rand + #350, #11
static rand + #351, #15
static rand + #352, #10
static rand + #353, #19
static rand + #354, #10
static rand + #355, #19
static rand + #356, #0
static rand + #357, #15
static rand + #358, #10
static rand + #359, #19
static rand + #360, #4
static rand + #361, #4
static rand + #362, #4
static rand + #363, #8
static rand + #364, #11
static rand + #365, #0
static rand + #366, #19
static rand + #367, #15
static rand + #368, #0
static rand + #369, #10
static rand + #370, #8
static rand + #371, #0
static rand + #372, #8
static rand + #373, #4
static rand + #374, #11
static rand + #375, #8
static rand + #376, #19
static rand + #377, #8
static rand + #378, #0
static rand + #379, #11
static rand + #380, #11
static rand + #381, #15
static rand + #382, #10
static rand + #383, #0
static rand + #384, #10
static rand + #385, #15
static rand + #386, #4
static rand + #387, #11
static rand + #388, #8
static rand + #389, #10
static rand + #390, #10
static rand + #391, #11
static rand + #392, #10
static rand + #393, #11
static rand + #394, #15
static rand + #395, #11
static rand + #396, #19
static rand + #397, #0
static rand + #398, #0
static rand + #399, #10
static rand + #400, #4
static rand + #401, #0
static rand + #402, #4
static rand + #403, #10
static rand + #404, #19
static rand + #405, #15
static rand + #406, #15
static rand + #407, #0
static rand + #408, #19
static rand + #409, #11
static rand + #410, #15
static rand + #411, #19
static rand + #412, #10
static rand + #413, #8
static rand + #414, #11
static rand + #415, #19
static rand + #416, #10
static rand + #417, #19
static rand + #418, #8
static rand + #419, #0
static rand + #420, #19
static rand + #421, #4
static rand + #422, #11
static rand + #423, #11
static rand + #424, #8
static rand + #425, #8
static rand + #426, #0
static rand + #427, #19
static rand + #428, #10
static rand + #429, #10
static rand + #430, #0
static rand + #431, #8
static rand + #432, #19
static rand + #433, #11
static rand + #434, #19
static rand + #435, #10
static rand + #436, #15
static rand + #437, #8
static rand + #438, #10
static rand + #439, #19
static rand + #440, #8
static rand + #441, #8
static rand + #442, #8
static rand + #443, #19
static rand + #444, #10
static rand + #445, #15
static rand + #446, #4
static rand + #447, #0
static rand + #448, #4
static rand + #449, #11
static rand + #450, #19
static rand + #451, #8
static rand + #452, #8
static rand + #453, #11
static rand + #454, #8
static rand + #455, #4
static rand + #456, #11
static rand + #457, #4
static rand + #458, #8
static rand + #459, #4
static rand + #460, #15
static rand + #461, #15
static rand + #462, #4
static rand + #463, #10
static rand + #464, #19
static rand + #465, #10
static rand + #466, #10
static rand + #467, #0
static rand + #468, #19
static rand + #469, #0
static rand + #470, #4
static rand + #471, #0
static rand + #472, #11
static rand + #473, #19
static rand + #474, #11
static rand + #475, #10
static rand + #476, #10
static rand + #477, #19
static rand + #478, #15
static rand + #479, #10
static rand + #480, #0
static rand + #481, #11
static rand + #482, #0
static rand + #483, #11
static rand + #484, #19
static rand + #485, #8
static rand + #486, #10
static rand + #487, #0
static rand + #488, #19
static rand + #489, #15
static rand + #490, #4
static rand + #491, #19
static rand + #492, #8
static rand + #493, #19
static rand + #494, #15
static rand + #495, #11
static rand + #496, #4
static rand + #497, #8
static rand + #498, #11
static rand + #499, #10
static rand + #500, #15
static rand + #501, #0
static rand + #502, #19
static rand + #503, #8
static rand + #504, #11
static rand + #505, #4
static rand + #506, #8
static rand + #507, #10
static rand + #508, #0
static rand + #509, #8
static rand + #510, #19
static rand + #511, #10
static rand + #512, #15
static rand + #513, #0
static rand + #514, #11
static rand + #515, #15
static rand + #516, #4
static rand + #517, #15
static rand + #518, #8
static rand + #519, #4
static rand + #520, #19
static rand + #521, #4
static rand + #522, #10
static rand + #523, #11
static rand + #524, #10
static rand + #525, #10
static rand + #526, #0
static rand + #527, #0
static rand + #528, #10
static rand + #529, #11
static rand + #530, #0
static rand + #531, #4
static rand + #532, #11
static rand + #533, #4
static rand + #534, #10
static rand + #535, #0
static rand + #536, #11
static rand + #537, #19
static rand + #538, #4
static rand + #539, #10
static rand + #540, #11
static rand + #541, #19
static rand + #542, #8
static rand + #543, #15
static rand + #544, #15
static rand + #545, #0
static rand + #546, #11
static rand + #547, #15
static rand + #548, #19
static rand + #549, #0
static rand + #550, #8
static rand + #551, #15
static rand + #552, #4
static rand + #553, #19
static rand + #554, #10
static rand + #555, #10
static rand + #556, #11
static rand + #557, #15
static rand + #558, #19
static rand + #559, #15
static rand + #560, #15
static rand + #561, #10
static rand + #562, #15
static rand + #563, #10
static rand + #564, #15
static rand + #565, #15
static rand + #566, #0
static rand + #567, #15
static rand + #568, #8
static rand + #569, #15
static rand + #570, #11
static rand + #571, #0
static rand + #572, #0
static rand + #573, #10
static rand + #574, #15
static rand + #575, #10
static rand + #576, #4
static rand + #577, #15
static rand + #578, #15
static rand + #579, #15
static rand + #580, #0
static rand + #581, #4
static rand + #582, #19
static rand + #583, #8
static rand + #584, #10
static rand + #585, #4
static rand + #586, #15
static rand + #587, #10
static rand + #588, #0
static rand + #589, #19
static rand + #590, #10
static rand + #591, #15
static rand + #592, #15
static rand + #593, #19
static rand + #594, #0
static rand + #595, #10
static rand + #596, #15
static rand + #597, #15
static rand + #598, #8
static rand + #599, #8
static rand + #600, #11
static rand + #601, #8
static rand + #602, #15
static rand + #603, #0
static rand + #604, #19
static rand + #605, #10
static rand + #606, #11
static rand + #607, #15
static rand + #608, #19
static rand + #609, #10
static rand + #610, #15
static rand + #611, #8
static rand + #612, #4
static rand + #613, #11
static rand + #614, #15
static rand + #615, #15
static rand + #616, #15
static rand + #617, #19
static rand + #618, #0
static rand + #619, #10
static rand + #620, #0
static rand + #621, #10
static rand + #622, #15
static rand + #623, #4
static rand + #624, #4
static rand + #625, #4
static rand + #626, #0
static rand + #627, #10
static rand + #628, #19
static rand + #629, #0
static rand + #630, #8
static rand + #631, #8
static rand + #632, #4
static rand + #633, #11
static rand + #634, #19
static rand + #635, #0
static rand + #636, #10
static rand + #637, #8
static rand + #638, #10
static rand + #639, #4
static rand + #640, #11
static rand + #641, #0
static rand + #642, #11
static rand + #643, #8
static rand + #644, #0
static rand + #645, #15
static rand + #646, #19
static rand + #647, #8
static rand + #648, #0
static rand + #649, #10
static rand + #650, #4
static rand + #651, #11
static rand + #652, #19
static rand + #653, #8
static rand + #654, #0
static rand + #655, #10
static rand + #656, #11
static rand + #657, #4
static rand + #658, #19
static rand + #659, #0
static rand + #660, #19
static rand + #661, #10
static rand + #662, #11
static rand + #663, #4
static rand + #664, #4
static rand + #665, #11
static rand + #666, #4
static rand + #667, #19
static rand + #668, #11
static rand + #669, #15
static rand + #670, #0
static rand + #671, #15
static rand + #672, #4
static rand + #673, #19
static rand + #674, #15
static rand + #675, #15
static rand + #676, #4
static rand + #677, #10
static rand + #678, #15
static rand + #679, #19
static rand + #680, #10
static rand + #681, #10
static rand + #682, #4
static rand + #683, #4
static rand + #684, #15
static rand + #685, #11
static rand + #686, #15
static rand + #687, #15
static rand + #688, #8
static rand + #689, #11
static rand + #690, #8
static rand + #691, #0
static rand + #692, #8
static rand + #693, #15
static rand + #694, #8
static rand + #695, #10
static rand + #696, #10
static rand + #697, #4
static rand + #698, #0
static rand + #699, #0
