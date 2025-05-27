make:
	./montador tetris.asm tetris.mif
	./sim tetris.mif charmap.mif

cp:
	./montador cp_tetris.asm cp_tetris.mif
	./sim cp_tetris.mif charmap.mif
