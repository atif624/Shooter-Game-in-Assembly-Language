;Game-Shooter
;Credits: Ibtisaam Butt

.model large
.stack 100h
.data

;-------- Point Structure for WORD --------;

Point struc
	x dw ?
	y dw ?
	color db ?
Point ends

;---------------------------------;

;-------- Point Structure for BYTE --------;

Point_Byte struc
	x db ?
	y db ?
	color db ?
Point_Byte ends

;---------------------------------;

;-------- Bullet Structure --------;

Bullet struc
	x db ?
	y db ?
	bool db 0
	color db ?

Bullet ends

;---------------------------------;

;-------- Background Structure --------;

Background struc
	xi db ?
	yi db ?
	xj db ?
	yj db ?
	color db ?

Background ends

;---------------------------------;

;-------- Life Structure --------;

Lives struc
	x db ?
	y db ?
	color db ?
	object_life dw ? 

Lives ends

;---------------------------------;

File db "myfile.txt",0
Data_string db 30 dup('$')

Screen Background<>
P Point<>

Cannon_A_Life Lives<>
Cannon_B_Life Lives<>
COAL_MAN_Life Lives<>

Cannon_A Point_Byte<>
Cannon_B Point_Byte<>
COAL_MAN Point_Byte<>

Objects_character db 0

Cannon_A_row db 0
Cannon_A_column db 0

Cannon_B_row db 0
Cannon_B_column db 0

COAL_MAN_row db 0
COAL_MAN_column db 0

row db 0
column db 0
character db 0

bool_A db 0
bool_B db 0
bool_C db 0
bool_mouse db 0
Mouse_click_bool dw 0

Bullet_A Bullet<>
Bullet_B Bullet<>
Bullet_C Bullet<>

divisor db 10
count dw 0

Score dw 0
Previous_y dw 25

bool_weapon db 3

CA_mov_var db 0
CB_mov_var db 0

CA_bullet_var db 0
CB_bullet_var db 0

Counter_var db 0

.code

;-------- Clear Registers --------;

Clear_registers proc

	mov ax,0
	mov bx,0
	mov cx,0
	mov dx,0
	
RET
Clear_registers endp

;-------- Character printing Procedure --------;

Character_ proc

	;Cursor Position

	mov ah,02	;Function Number
	mov dh,row	;Row Number
	mov dl,column	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,character	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,150	;White Color
	int 10h		;Interrupt

RET
Character_ endp

;-------- Displaying Cannon A character --------;

Display_Cannon_A_character proc

	;Cursor Position

	mov ah,02	;Function Number
	mov dh,Cannon_A.x	;Row Number
	mov dl,Cannon_A.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,Objects_character	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,Cannon_A.color	;White Color
	int 10h		;Interrupt

RET
Display_Cannon_A_character endp

;-------- Displaying Cannon B character --------;

Display_Cannon_B_character proc

	;Cursor Position

	mov ah,02	;Function Number
	mov dh,Cannon_B.x	;Row Number
	mov dl,Cannon_B.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,Objects_character	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,150	;White Color
	int 10h		;Interrupt

RET
Display_Cannon_B_character endp

;-------- Displaying COAL MAN character --------;

Display_COAL_MAN_character proc

	;Cursor Position

	mov ah,02	;Function Number
	mov dh,COAL_MAN.x	;Row Number
	mov dl,COAL_MAN.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,Objects_character	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,150	;White Color
	int 10h		;Interrupt

RET
Display_COAL_MAN_character endp

;-------- Displaying Cannon A --------;

Display_Cannon_A proc

	cmp Cannon_A_Life.object_life,0
	jbe Cannon_A_destroyed
	
		mov al,Cannon_A_row
		mov Cannon_A.x,al
		mov al,Cannon_A_column
		mov Cannon_A.y,al
		mov Cannon_A.color,150
		mov Objects_character,'|'
		call Display_Cannon_A_character
			
		add Cannon_A.y,3
		mov Cannon_A.color,150
		mov Objects_character,'\'
		call Display_Cannon_A_character

		add Cannon_A.y,4
		mov Cannon_A.color,150
		mov Objects_character,'/'
		call Display_Cannon_A_character

		add Cannon_A.y,3
		mov Cannon_A.color,150
		mov Objects_character,'|'
		call Display_Cannon_A_character

		inc Cannon_A.x
		mov al,Cannon_A_column
		mov Cannon_A.y,al
		inc Cannon_A.y
		mov Cannon_A.color,150
		mov Objects_character,'\'
		call Display_Cannon_A_character

		inc Cannon_A.y
		mov Cannon_A.color,150
		mov Objects_character,'('
		call Display_Cannon_A_character

		inc Cannon_A.y
		mov Cannon_A.color,150
		mov Objects_character,4
		call Display_Cannon_A_character

		add Cannon_A.y,2
		mov Cannon_A.color,150
		mov Objects_character,22
		call Display_Cannon_A_character

		add Cannon_A.y,2
		mov Cannon_A.color,150
		mov Objects_character,4
		call Display_Cannon_A_character

		inc Cannon_A.y
		mov Cannon_A.color,150
		mov Objects_character,')'
		call Display_Cannon_A_character

		inc Cannon_A.y
		mov Cannon_A.color,150
		mov Objects_character,'/'
		call Display_Cannon_A_character

		inc Cannon_A.x
		mov al,Cannon_A_column
		mov Cannon_A.y,al
		add Cannon_A.y,5
		mov Cannon_A.color,150
		mov Objects_character,12
		call Display_Cannon_A_character
		
	Cannon_A_destroyed:
	
RET
Display_Cannon_A endp

;-------- Displaying Cannon B --------;

Display_Cannon_B proc

	cmp Cannon_B_Life.object_life,0
	jbe Cannon_B_destroyed

		mov al,Cannon_B_row
		mov Cannon_B.x,al
		mov al,Cannon_B_column
		mov Cannon_B.y,al
		mov Cannon_B.color,150
		mov Objects_character,'|'
		call Display_Cannon_B_character
			
		add Cannon_B.y,3
		mov Cannon_B.color,150
		mov Objects_character,'\'
		call Display_Cannon_B_character

		add Cannon_B.y,4
		mov Cannon_B.color,150
		mov Objects_character,'/'
		call Display_Cannon_B_character

		add Cannon_B.y,3
		mov Cannon_B.color,150
		mov Objects_character,'|'
		call Display_Cannon_B_character
		
		inc Cannon_B.x
		mov al,Cannon_B_column
		mov Cannon_B.y,al
		inc Cannon_B.y
		mov Cannon_B.color,150
		mov Objects_character,'\'
		call Display_Cannon_B_character

		inc Cannon_B.y
		mov Cannon_B.color,150
		mov Objects_character,'('
		call Display_Cannon_B_character
		
		inc Cannon_B.y
		mov Cannon_B.color,150
		mov Objects_character,'^'
		call Display_Cannon_B_character

		add Cannon_B.y,2
		mov Cannon_B.color,150
		mov Objects_character,22
		call Display_Cannon_B_character

		add Cannon_B.y,2
		mov Cannon_B.color,150
		mov Objects_character,'^'
		call Display_Cannon_B_character

		inc Cannon_B.y
		mov Cannon_B.color,150
		mov Objects_character,')'
		call Display_Cannon_B_character

		inc Cannon_B.y
		mov Cannon_B.color,150
		mov Objects_character,'/'
		call Display_Cannon_B_character

		inc Cannon_B.x
		mov al,Cannon_B_column
		mov Cannon_B.y,al
		add Cannon_B.y,5
		mov Cannon_B.color,150
		mov Objects_character,11
		call Display_Cannon_B_character

	Cannon_B_destroyed:

RET
Display_Cannon_B endp

;-------- Displaying COAL MAN --------;

Display_COAL_MAN proc

	cmp COAL_MAN_Life.object_life,0
	jbe COAL_MAN_destroyed

		mov al,COAL_MAN_row
		mov COAL_MAN.x,al
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		mov Cannon_B.color,150
		mov Objects_character,'x'
		call Display_COAL_MAN_character
			
		sub COAL_MAN.x,2
		add COAL_MAN.y,3
		mov COAL_MAN.color,150
		mov Objects_character,'<'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'\'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
	;	mov Objects_character,'~'
		mov Objects_character,'_'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,' '
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
	;	mov Objects_character,'~'
		mov Objects_character,'_'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'/'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'>'
		call Display_COAL_MAN_character

		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		add COAL_MAN.y,4
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,4
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'.'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,4
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		dec COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character
		
		add COAL_MAN.y,2
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		add COAL_MAN.y,3
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character
		
		add COAL_MAN.y,2
		mov COAL_MAN.color,150
		mov Objects_character,3
		call Display_COAL_MAN_character

		add COAL_MAN.y,2
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		mov COAL_MAN.color,150
		mov Objects_character,'\'
		call Display_COAL_MAN_character

		add COAL_MAN.y,3
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character
		
		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'_'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'C'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'O'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'A'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'L'
		call Display_COAL_MAN_character

		add COAL_MAN.y,2
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		add COAL_MAN.y,3
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'M'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'A'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'N'
		call Display_COAL_MAN_character
		
		add COAL_MAN.y,3
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		add COAL_MAN.y,2
		mov COAL_MAN.color,150
		mov Objects_character,'\'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		add COAL_MAN.y,3
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'='
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character
		
		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		add COAL_MAN.y,4
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		add COAL_MAN.y,4
		mov COAL_MAN.color,150
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.x
		mov al,COAL_MAN_column
		mov COAL_MAN.y,al
		add COAL_MAN.y,3
		mov COAL_MAN.color,100
		mov Objects_character,'_'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,100
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		add COAL_MAN.y,4
		mov COAL_MAN.color,100
		mov Objects_character,'|'
		call Display_COAL_MAN_character

		inc COAL_MAN.y
		mov COAL_MAN.color,100
		mov Objects_character,'_'
		call Display_COAL_MAN_character
		
	COAL_MAN_destroyed:

RET
Display_COAL_MAN endp

;-------- Screen select --------;

Display_screen proc

	mov ax,0
	mov al,12h
	int 10h

RET
Display_screen endp

;-------- Change Background --------;

Change_Background proc

    mov ah, 06h ; Function Number
    mov al, 0   
    mov ch, Screen.yi	;Upper Row number/ Y axis of first point
    mov cl,Screen.xi	;Left column number/ X axis of first point
    mov dh, Screen.yj	;Lower Row number/ Y axis of second point
    mov dl, Screen.xj	;Right column number/ X axis of second point
    mov bh, Screen.color	;Color number
    int 10h

RET
Change_Background endp

;-------- Display Cannon A lives --------;

Display_Cannon_A_life proc

	mov ah, 02	;Function Number
	mov dh, Cannon_A_Life.x	;Row Number
	mov dl, Cannon_A_Life.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,'|'	;Character which is to be printed
	mov cx,Cannon_A_life.object_life	;Character count
	mov bh,0
	mov bl,Cannon_A_Life.color	;Color
	int 10h		;Interrupt

RET
Display_Cannon_A_life endp

;-------- Display Cannon B lives --------;

Display_Cannon_B_life proc

	mov ah, 02	;Function Number
	mov dh, Cannon_B_Life.x	;Row Number
	mov dl, Cannon_B_Life.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,'|'	;Character which is to be printed
	mov cx,Cannon_B_life.object_life	;Character count
	mov bh,0
	mov bl,Cannon_B_Life.color	;Color
	int 10h		;Interrupt

RET
Display_Cannon_B_life endp

;-------- Display COAL MAN lives --------;

Display_COAL_MAN_life proc

	mov ah, 02	;Function Number
	mov dh, COAL_MAN_life.x	;Row Number
	mov dl, COAL_MAN_life.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,'|'	;Character which is to be printed
	mov cx,COAL_MAN_life.object_life	;Character count
	mov bh,0
	mov bl,COAL_MAN_life.color	;Color
	int 10h		;Interrupt

RET
Display_COAL_MAN_life endp

;-------- Display Cannon A Bullet --------;

Move_Bullet_A proc

	mov ah, 02	;Function Number
	mov dh, Bullet_A.x	;Row Number
	mov dl, Bullet_A.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,3	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,Bullet_A.color	;Color
	int 10h		;Interrupt

RET
Move_Bullet_A endp

;-------- Display Cannon B Bullet --------;

Move_Bullet_B proc

	mov ah, 02	;Function Number
	mov dh, Bullet_B.x	;Row Number
	mov dl, Bullet_B.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,3	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,Bullet_B.color	;Color
	int 10h		;Interrupt

RET
Move_Bullet_B endp

;-------- Display COAL MAN Bullet --------;

Move_Bullet_C proc

	mov ah, 02	;Function Number
	mov dh, Bullet_C.x	;Row Number
	mov dl, Bullet_C.y	;Column Number
	int 10h		;Interrupt

	mov ah,09h	;Function Number
		mov al,18h	;Character which is to be printed
	mov cx,1	;Character count
	mov bh,0
	mov bl,Bullet_C.color	;Color
	int 10h		;Interrupt

RET
Move_Bullet_C endp

;-------- Display Cannon A name --------;

Cannon_A_name proc

	mov row, 4
	
		mov column, 65
	mov character, 'C'
	call Character_
		mov column, 66
	mov character, 'a'
	call Character_
		mov column, 67
	mov character, 'n'
	call Character_
		mov column, 68
	mov character, 'n'
	call Character_
		mov column, 69
	mov character, 'o'
	call Character_
		mov column, 70
	mov character, 'n'
	call Character_
		mov column, 71
	mov character, ' '
	call Character_
		mov column, 72
	mov character, 'A'
	call Character_

RET
Cannon_A_name endp

;-------- Display Cannon B name --------;

Cannon_B_name proc

	mov row, 7
	
		mov column, 65
	mov character, 'C'
	call Character_
		mov column, 66
	mov character, 'a'
	call Character_
		mov column, 67
	mov character, 'n'
	call Character_
		mov column, 68
	mov character, 'n'
	call Character_
		mov column, 69
	mov character, 'o'
	call Character_
		mov column, 70
	mov character, 'n'
	call Character_
		mov column, 71
	mov character, ' '
	call Character_
		mov column, 72
	mov character, 'B'
	call Character_

RET
Cannon_B_name endp

;-------- Display COAL MAN name --------;

COAL_MAN_name proc

	mov row, 10
	
		mov column, 65
	mov character, 'C'
	call Character_
		mov column, 66
	mov character, 'O'
	call Character_
		mov column, 67
	mov character, 'A'
	call Character_
		mov column, 68
	mov character, 'L'
	call Character_
		mov column, 69
	mov character, ' '
	call Character_
		mov column, 70
	mov character, 'M'
	call Character_
		mov column, 71
	mov character, 'a'
	call Character_
		mov column, 72
	mov character, 'n'
	call Character_

RET
COAL_MAN_name endp

;-------- Display Score heading --------;

Score_name proc

	mov row, 14
	
		mov column, 65
	mov character, 'S'
	call Character_
		mov column, 66
	mov character, 'c'
	call Character_
		mov column, 67
	mov character, 'o'
	call Character_
		mov column, 68
	mov character, 'r'
	call Character_
		mov column, 69
	mov character, 'e'
	call Character_
		mov column, 70
	mov character, ':'
	call Character_
		mov column, 71
	mov character, ' '
	call Character_

RET
Score_name endp

;-------- Print Score --------;

Output_score proc

mov count,0
mov ax,0
mov ax,score

Output:
	mov divisor,10
	div divisor
	mov dx,0
	mov dl,ah

	push dx
	inc count

	cmp al,0
	je Print
	
	mov ah,0
	jmp Output

Print:
	mov cx,count
	Print_number:
		pop ax
		mov dl,al
		add dl,48
		mov ah,02h
		int 21h
		Loop Print_number

RET
Output_score endp

;-------- Move Robot --------;

Move_Random_Robot proc

	cmp bool_C,0
	je Right_Cannon_C
	jne Left_Cannon_C
	
		Right_Cannon_C:
			inc COAL_MAN_column
			cmp COAL_MAN_column, 49
			je Move_C_Left
			jmp Moved_Cannon_C
			
				Move_C_Left:
					mov bool_C,1
					jmp Moved_Cannon_C
					
		Left_Cannon_C:
			dec COAL_MAN_column
			cmp COAL_MAN_column,1
			je Move_C_Right
			jmp Moved_Cannon_C
			
				Move_C_Right:
					mov bool_C,0
					jmp Moved_Cannon_C
					
	Moved_Cannon_C:
		call Clear_registers
		call Display_COAL_MAN

RET
Move_Random_Robot endp

;-------- Move Cannon A --------;

Move_Cannon_A proc

	call Clear_registers
	cmp bool_A,0
	je Right_Cannon_A
	jne Left_Cannon_A
	
	Right_Cannon_A:
		mov al,CA_mov_var
		add Cannon_A_column,al
		cmp Cannon_A_column, 50
		je Move_A_Left
		jmp Moved_Cannon_A
		
			Move_A_Left:
				mov bool_A,1
				jmp Moved_Cannon_A
				
	Left_Cannon_A:
		mov al,CA_mov_var
		sub Cannon_A_column,al
		cmp Cannon_A_column,0
		je Move_A_Right
		jmp Moved_Cannon_A
		
			Move_A_Right:
				mov bool_A,0
				jmp Moved_Cannon_A
					
	Moved_Cannon_A:
	
RET
Move_Cannon_A endp

;-------- Shoot Cannon A bullet --------;

Shoot_Bullet_A proc

	cmp Bullet_A.x,22
	je Bullet_reload_A
	jmp No_reload_A
	
	Bullet_reload_A:
		mov Bullet_A.bool,1

	No_reload_A:
	
		call Clear_registers
		cmp Bullet_A.bool,1
		je New_bullet_A
		jmp Keep_shooting_A
		
		New_bullet_A:
			mov ax,0
			mov al,Cannon_A_column
			add al,4
			mov Bullet_A.y,al
			mov Bullet_A.x,2
			mov Bullet_A.bool,0
			
	Keep_shooting_A:

RET
Shoot_Bullet_A endp

;-------- Move Cannon B --------;

Move_Cannon_B proc

	cmp bool_B,0
	je Right_Cannon_B
	jne Left_Cannon_B
	
		Right_Cannon_B:
			mov al,CB_mov_var
			add Cannon_B_column,al
			cmp Cannon_B_column, 50
			je Move_B_Left
			jmp Moved_Cannon_B
			
				Move_B_Left:
					mov bool_B,1
					jmp Moved_Cannon_B
					
		Left_Cannon_B:
			mov al,CB_mov_var
			sub Cannon_B_column,al
			cmp Cannon_B_column,0
			je Move_B_Right
			jmp Moved_Cannon_B
			
		Move_B_Right:
			mov bool_B,0
			jmp Moved_Cannon_B
					
	Moved_Cannon_B:

RET
Move_Cannon_B endp

;-------- Shoot Cannon B bullet --------;

Shoot_Bullet_B proc

	cmp Bullet_B.x,22
	je Bullet_reload_B
	jmp No_reload_B
	
	Bullet_reload_B:
		mov Bullet_B.bool,1

	No_reload_B:
	
		call Clear_registers
		cmp Bullet_B.bool,1
		je New_bullet_B
		jmp Keep_shooting_B
		
		New_bullet_B:
			mov ax,0
			mov al,Cannon_B_column
			add al,4
			mov Bullet_B.y,al
			mov Bullet_B.x,2
			mov Bullet_B.bool,0
			
	Keep_shooting_B:

RET
Shoot_Bullet_B endp

;-------- Shoot COAL MAN bullet from keyboard --------;

Shoot_Bullet_C_keyboard proc

	cmp Bullet_C.x,0
	je Bullet_reload_C
	jmp No_reload_C
	
	Bullet_reload_C:
		mov Bullet_C.bool,1

	No_reload_C:
	
		call Clear_registers
		cmp Bullet_C.bool,1
		je New_bullet_C
		jmp Keep_shooting_C
		
		New_bullet_C:
			mov ax,0
			mov al,COAL_MAN_column
			mov Bullet_C.y,al
			mov Bullet_C.x,15
			mov Bullet_C.bool,0
			call Sound_Fire_Bullet
			
		Keep_shooting_C:

RET
Shoot_Bullet_C_keyboard endp

;-------- Shoot Coal Man bullet from mouse--------;

Shoot_Bullet_C_mouse proc

	cmp Bullet_C.x,0
	je Bullet_reload_C
	jmp No_reload_C
	
	Bullet_reload_C:
		mov Bullet_C.bool,1

	No_reload_C:
	
		call Clear_registers
		cmp Bullet_C.bool,1
		je New_bullet_C
		jmp Keep_shooting_C
		
		New_bullet_C:
			mov bool_mouse,0
			
		Keep_shooting_C:

RET
Shoot_Bullet_C_mouse endp

;-------- Movement through keyboard --------;

Keyboard_Movement proc

	call Clear_registers

	mov ah,01h
	int 16h
	mov dh,ah
		
	cmp dh,4BH
	je Make_left
	
	cmp dh,4DH
	je Make_right

	cmp COAL_MAN_column,1
	jbe Boundary_reached

	cmp COAL_MAN_column,49
	jae Boundary_reached
	
	jmp Check_Robot_bool 
	
	Make_right:
		cmp COAL_MAN_column,49
		jae Boundary_reached
		mov bool_C,0
		jmp Check_Robot_bool

	Make_left:
		cmp COAL_MAN_column,1
		jbe Boundary_reached
		mov bool_C,1
		jmp Check_Robot_bool		
		
	Boundary_reached:
		mov bool_C,3
		
	Check_Robot_bool:
		cmp bool_C,0
		je Move_robot_right
		
		cmp bool_C,1
		je Move_robot_left
		
		jmp Robot_Moved
	
			Move_robot_right:
				inc COAL_MAN_column
				jmp Robot_Moved
				
			Move_robot_left:
				dec COAL_MAN_column
	
	Robot_Moved:
		mov ah,0ch
		int 21h

RET
Keyboard_Movement endp

;-------- Movement through mouse --------;

Mouse_Movement proc

	call Clear_registers

	mov ax,3
	int 33h
		
	cmp cx,Previous_y
	jb Make_left
	
	cmp cx,Previous_y
	ja Make_right

	cmp COAL_MAN_column,1
	jbe Boundary_reached

	cmp COAL_MAN_column,49
	jae Boundary_reached
	
	jmp Check_Robot_bool 
	
	Make_right:
		cmp COAL_MAN_column,49
		jae Boundary_reached
		mov bool_C,0
		jmp Check_Robot_bool

	Make_left:
		cmp COAL_MAN_column,1
		jbe Boundary_reached
		mov bool_C,1
		jmp Check_Robot_bool		
		
	Boundary_reached:
		mov bool_C,3
		
	Check_Robot_bool:
		cmp bool_C,0
		je Move_robot_right
		
		cmp bool_C,1
		je Move_robot_left
		
		jmp Robot_Moved
	
			Move_robot_right:
				inc COAL_MAN_column
				jmp Robot_Moved
				
			Move_robot_left:
				dec COAL_MAN_column
	
	Robot_Moved:
		mov Previous_y,cx
		mov ah,0ch
		int 21h

RET
Mouse_Movement endp

;-------- Bullet detection from Cannon A --------;

Bullet_damage_A	proc

	call Clear_registers
	
	cmp Bullet_A.x,13
	je Row_reached_A
	jmp No_Collision_A
	
	Row_reached_A:
		mov al,COAL_MAN_column
		add al,3
		cmp Bullet_A.y,al
		jae Collision_possible_A
		jmp No_Collision_A

		Collision_possible_A:
			add al,7
			cmp Bullet_A.y,al
			jbe Bullet_detection_A
			jmp No_Collision_A
		
		Bullet_detection_A:
			dec COAL_MAN_life.object_life
			call Lives_column
			call Display_Lives
		
	No_Collision_A:

RET
Bullet_damage_A endp

;-------- Bullet detection from Cannon B --------;

Bullet_damage_B	proc

	call Clear_registers
	
	cmp Bullet_B.x,14
	je Row_reached_B
	jmp No_Collision_B
	
	Row_reached_B:
		mov al,COAL_MAN_column
		add al,3
		cmp Bullet_B.y,al
		jae Collision_possible_B
		jmp No_Collision_B

		Collision_possible_B:
			add al,7
			cmp Bullet_B.y,al
			jbe Bullet_detection_B
			jmp No_Collision_B
		
		Bullet_detection_B:
			dec COAL_MAN_life.object_life
			call Lives_column
			call Display_Lives
		
	No_Collision_B:

RET
Bullet_damage_B endp

;-------- Bullet detection from COAL MAN to Cannon A --------;

Bullet_damage_COAL_A proc

	call Clear_registers
	
	cmp Bullet_C.x,2
	je Row_reached_COAL_A
	jmp No_Collision_COAL_A
	
	Row_reached_COAL_A:
		mov al,Cannon_A_column
		add al,2
		cmp Bullet_C.y,al
		jae Collision_possible_COAL_A
		jmp No_Collision_COAL_A

		Collision_possible_COAL_A:
			add al,6
			cmp Bullet_C.y,al
			jbe Bullet_detection_COAL_A
			jmp No_Collision_COAL_A
		
		Bullet_detection_COAL_A:
			dec Cannon_A_Life.object_life
			add score,20
			call Lives_column
			call Display_Lives
		
	No_Collision_COAL_A:

RET
Bullet_damage_COAL_A endp

;-------- Bullet detection from COAL MAN to Cannon B --------;

Bullet_damage_COAL_B proc

	call Clear_registers
	
	cmp Bullet_C.x,2
	je Row_reached_COAL_B
	jmp No_Collision_COAL_B
	
	Row_reached_COAL_B:
		mov al,Cannon_B_column
		add al,2
		cmp Bullet_C.y,al
		jae Collision_possible_COAL_B
		jmp No_Collision_COAL_B

		Collision_possible_COAL_B:
			add al,6
			cmp Bullet_C.y,al
			jbe Bullet_detection_COAL_B
			jmp No_Collision_COAL_B
		
		Bullet_detection_COAL_B:
			dec Cannon_B_Life.object_life
			add score,20
			call Lives_column
			call Display_Lives
		
	No_Collision_COAL_B:

RET
Bullet_damage_COAL_B endp

;-------- A macro to display pixel --------;

	DisplayPixel macro a
		mov ah,0ch
		mov al,a.color
		mov cx,a.y
		mov dx,a.x
		int 10h
	endm

;-------- Display a line --------;
	
Display_Line proc

	mov P.x,210
	mov P.y,504
	mov P.color,150
	mov cx,120

	Outer_loop:
		push cx
		DisplayPixel P
		inc P.y
		pop cx
		
	Loop Outer_loop

RET
Display_Line endp

;-------- Background Color --------;

Background_color proc
		
	;	********** Change Background Colors **********

		mov Screen.xi, 0
		mov Screen.yi, 0
		mov Screen.xj, 60
		mov Screen.yj, 29
		mov Screen.color, 09h	;Light blue background
		call Change_Background
		
		mov Screen.xi, 0
		mov Screen.yi, 22
		mov Screen.xj, 79
		mov Screen.color, 02h	;Dark green background
		call Change_Background

		mov Screen.xi, 0
		mov Screen.yi, 25
		mov Screen.color, 0Ah	;Light green background
		call Change_Background
				
RET
Background_color endp

;-------- Display Lives and score column --------;

Lives_column proc

		mov Screen.xi, 63
		mov Screen.yi, 1
		mov Screen.xj, 77
		mov Screen.yj, 20
		mov Screen.color, 09h	;Light blue background
		call Change_Background
		
;	********** Displaying Names of objects **********

		call Clear_registers
		call Cannon_A_name

		call Clear_registers
		call Cannon_B_name

		call Clear_registers
		call COAL_MAN_name

		call Display_Line
		call Clear_registers
		call Score_name

RET
Lives_column endp

;-------- Display Lives and score column --------;

Move_bullet_via_mouse proc

	cmp bool_mouse,0
	je Check_click
	jne Do_Not_check_click
	
		Check_click:
			cmp Mouse_click_bool,1
			je Clicked
			jmp Not_clicked
	
			Clicked:
				call Sound_Fire_Bullet
				mov ax,0
				mov al,COAL_MAN_column
				mov Bullet_C.y,al
				mov Bullet_C.x,16
				mov Bullet_C.bool,0
				mov bool_mouse,1
	
	Do_Not_check_click:
			call Shoot_Bullet_C_mouse
			cmp bool_mouse,0
			jne Shoot
			jmp Do_not_shoot
			
			Shoot:
				call Move_Bullet_C
				dec Bullet_C.x
				dec Bullet_C.x
			
			Do_not_shoot:
	
	Not_clicked:
		mov bx,0

RET
Move_bullet_via_mouse endp

;-------- Display Cannon and COAL MAN lives --------;

Display_Lives proc
	
	cmp Cannon_A_Life.object_life,0
	jbe skip_1
	call Clear_registers
	call Display_Cannon_A_life
	
	skip_1:
		cmp Cannon_B_Life.object_life,0
		jbe skip_2
		call Clear_registers
		call Display_Cannon_B_life

	skip_2:
		cmp COAL_MAN_Life.object_life,0
		jbe skip_3
		call Clear_registers
		call Display_COAL_MAN_life
	
	skip_3:

RET
Display_Lives endp

;-------- Initial Interface --------;

Initial_Interface proc
	
	mov Screen.xi, 0
	mov Screen.yi, 0
	mov Screen.xj, 79
	mov Screen.yj, 8
	mov Screen.color, 09h	;Light blue background
	call Change_Background
	
	mov Screen.xi, 0
	mov Screen.yi, 9
	mov Screen.xj, 79
	mov Screen.yj, 29
	mov Screen.color, 0Eh	;Yellow background
	call Change_Background

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Moto_msg
	mov dl,26
	mov dh,7
	push cs
	pop es
	mov bp,offset Moto_msg
	mov ah,13h
	int 10h
	jmp this_msg
	Moto_msg db "'Work Smarter, Not Harder'"
	this_msg:
	
	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Welcome_msg
	mov dl,35
	mov dh,14
	push cs
	pop es
	mov bp,offset Welcome_msg
	mov ah,13h
	int 10h
	jmp this_msg_2
	Welcome_msg db "Welcome to"
	this_msg_2:

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Name_msg
	mov dl,28
	mov dh,16
	push cs
	pop es
	mov bp,offset Name_msg
	mov ah,13h
	int 10h
	jmp this_msg_3
	Name_msg db "ATIF - IBTISAAM Robotics"
	this_msg_3:

RET
Initial_Interface endp

;-------- Initial Interface number two --------;

Select_screen proc

	mov Screen.xi, 0
	mov Screen.yi, 0
	mov Screen.xj, 79
	mov Screen.yj, 14
	mov Screen.color, 0Eh	;Light Yellow background
	call Change_Background
	
	mov Screen.xi, 0
	mov Screen.yi, 14
	mov Screen.xj, 39
	mov Screen.yj, 29
	mov Screen.color, 0Ch	;Red background
	call Change_Background
	
	mov Screen.xi, 39
	mov Screen.yi, 14
	mov Screen.xj, 79
	mov Screen.yj, 29
	mov Screen.color, 0Ah	;Green background
	call Change_Background

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Game
	mov dl,34
	mov dh,7
	push cs
	pop es
	mov bp,offset Game
	mov ah,13h
	int 10h
	jmp this_msg
	Game db "'CANNON WAR'"
	this_msg:
	
	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Mouse_msg
	mov dl,8
	mov dh,22
	push cs
	pop es
	mov bp,offset Mouse_msg
	mov ah,13h
	int 10h
	jmp this_msg_2
	Mouse_msg db "Click to select mouse."
	this_msg_2:

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Keyboard_msg
	mov dl,45
	mov dh,22
	push cs
	pop es
	mov bp,offset Keyboard_msg
	mov ah,13h
	int 10h
	jmp this_msg_3
	Keyboard_msg db "Press 'K' to select keyboard."
	this_msg_3:

RET
Select_screen endp

;-------- Initial Interface number three --------;

Select_screen_keyboard proc

	mov Screen.xi, 0
	mov Screen.yi, 0
	mov Screen.xj, 79
	mov Screen.yj, 29
	mov Screen.color, 02h	;Black background
	call Change_Background

	mov Screen.xi, 2
	mov Screen.yi, 2
	mov Screen.xj, 77
	mov Screen.yj, 27
	mov Screen.color, 0Ah	;Green background
	call Change_Background
	
	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Keyb
	mov dl,20
	mov dh,14
	push cs
	pop es
	mov bp,offset Keyb
	mov ah,13h
	int 10h
	jmp this_msgd
	Keyb db "YOU HAVE SELECTED KEYBOARD AS YOUR WEAPON!"
	this_msgd:
	
	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Keybb
	mov dl,24
	mov dh,16
	push cs
	pop es
	mov bp,offset Keybb
	mov ah,13h
	int 10h
	jmp this_msgdddd
	Keybb db "USE ARROW KEYS TO MOVE KEYBOARD!"
	this_msgdddd:

	call Clear_registers
	mov cx,002Fh
	mov dx,0FFFFh
	mov ah,86h
	int 15h
	call Clear_registers

RET
Select_screen_keyboard endp

;-------- Initial Interface number three --------;

Select_screen_mouse proc

	mov Screen.xi, 0
	mov Screen.yi, 0
	mov Screen.xj, 79
	mov Screen.yj, 29
	mov Screen.color, 04h	;Black background
	call Change_Background

	mov Screen.xi, 2
	mov Screen.yi, 2
	mov Screen.xj, 77
	mov Screen.yj, 27
	mov Screen.color, 0Ch	;Red background
	call Change_Background
	
	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Mos
	mov dl,20
	mov dh,14
	push cs
	pop es
	mov bp,offset Mos
	mov ah,13h
	int 10h
	jmp this_msgdd
	Mos db "YOU HAVE SELECTED MOUSE AS YOUR WEAPON!"
	this_msgdd:

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Moss
	mov dl,24
	mov dh,16
	push cs
	pop es
	mov bp,offset Moss
	mov ah,13h
	int 10h
	jmp this_msgddd
	Moss db "CLICK MOUSE BUTTON TO SHOOT!"
	this_msgddd:

	call Clear_registers
	mov cx,002Fh
	mov dx,0FFFFh
	mov ah,86h
	int 15h
	call Clear_registers
	
RET
Select_screen_mouse endp

;-------- Easy / Medium / Hard --------;

Change_Difficulty proc

	mov Screen.xi, 0
	mov Screen.yi, 0
	mov Screen.xj, 79
	mov Screen.yj, 29
	mov Screen.color, 00h	;Black background
	call Change_Background

	mov Screen.xi, 0
	mov Screen.yi, 0
	mov Screen.xj, 79
	mov Screen.yj, 8
	mov Screen.color, 0Ah	;Green background
	call Change_Background

	mov Screen.xi, 0
	mov Screen.yi, 10
	mov Screen.xj, 79
	mov Screen.yj, 19
	mov Screen.color, 0Eh	;Yellow background
	call Change_Background

	mov Screen.xi, 0
	mov Screen.yi, 21
	mov Screen.xj, 79
	mov Screen.yj, 29
	mov Screen.color, 0Ch	;Red background
	call Change_Background
	
	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Easy
	mov dl,31
	mov dh,4
	push cs
	pop es
	mov bp,offset Easy
	mov ah,13h
	int 10h
	jmp msgd
	Easy db "Press 1 for EASY Mode!"
	msgd:

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Med
	mov dl,29
	mov dh,14
	push cs
	pop es
	mov bp,offset Med
	mov ah,13h
	int 10h
	jmp msgdd
	Med db "Press 2 for MEDIUM Mode"
	msgdd:

	mov ah,0
	mov al,0
	mov bh,0
	mov bl,130
	mov cx,lengthof Hard
	mov dl,31
	mov dh,24
	push cs
	pop es
	mov bp,offset Hard
	mov ah,13h
	int 10h
	jmp msgddd
	Hard db "Press 3 for HARD Mode"
	msgddd:

	call Clear_registers
	mov cx,002Fh
	mov dx,0FFFFh
	mov ah,86h
	int 15h
	call Clear_registers
	
RET
Change_Difficulty endp

;-------- Sound Initial --------;

Sound_Initial proc
		
	mov bx, 2500
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_01:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 8000
	jnz Frequency_change_01

	mov bx, 3000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_02:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 8000
	jnz Frequency_change_02
	
	
	mov bx, 2200
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_03:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 8000
	jnz Frequency_change_03

	mov bx, 2700
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_04:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 8000
	jnz Frequency_change_04


	mov bx, 1900
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_05:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 8000
	jnz Frequency_change_05

	mov bx, 2400
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_06:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 8000
	jnz Frequency_change_06
		
	
	mov bx, 1200
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_07:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx
	
	cmp dx, 16000
	jnz Frequency_change_07
	
	in al, 61h
	and al, 11111100b
	out 61h, al
	
ret 
Sound_Initial endp

;-------- Sound fire Start --------;

Sound_Fire_start proc
		
	mov bx, 500
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_1:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	add bx,1
	cmp dx, 20000
	jnz Frequency_change_1

	mov bx, 20500
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_2:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	dec bx
	cmp dx, 20000
	jnz Frequency_change_2

	in al, 61h
	and al, 11111100b
	out 61h, al
	
ret 
Sound_Fire_start endp

;-------- Winning Sound --------;

Sound_Win proc
		
	mov bx, 4000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	
	Freq_change_1:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	;add bx,1
	cmp dx, 10000
	jnz Freq_change_1

	mov bx, 3000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Freq_change_2:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	;dec bx
	cmp dx, 10000
	jnz Freq_change_2

	
	mov bx, 2000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Freq_change_3:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	;dec bx
	cmp dx, 20000
	jnz Freq_change_3

	
	in al, 61h
	and al, 11111100b
	out 61h, al
	
ret 
Sound_Win endp

;-------- Losing sound --------;

Sound_Lose proc
		
	mov bx, 2000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Freq_change_01:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	;add bx,1
	cmp dx, 10000
	jnz Freq_change_01

	mov bx, 3000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Freq_change_02:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	;dec bx
	cmp dx, 10000
	jnz Freq_change_02

	
	mov bx, 4000
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Freq_change_03:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	cmp dx, 20000
	jnz Freq_change_03	
	
	
	in al, 61h
	and al, 11111100b
	out 61h, al
	
ret 
Sound_Lose endp

;-------- Bullet sound --------;

Sound_Fire_Bullet proc
		
	mov bx, 100
	mov dx, 0
	mov al, 10110110B
	out 43h, al
	Frequency_change_1:
		mov ax, bx
		
		out 42h, al
		mov al, ah
		out 42h, al
		
		in al, 61h
		or al, 00000011b
		out 61h, al

	inc dx

	add bx,1
	cmp dx, 2000
	jnz Frequency_change_1

	in al, 61h
	and al, 11111100b
	out 61h, al
	
ret 
Sound_Fire_Bullet endp




;Write

;mov ah,3dh
;mov al,1
;mov dx,offset file
;int 21h

;mov bx,ax
;mov cx,20
;mov dx, offset datainfile

;mov ah,40h
;int 21h
;call Clear_registers

;Read
;mov ah,3dh
;mov al,0

;mov dx,offset file
;int 21h

;mov bx,ax
;mov cx,20
;mov dx,offset datainfile

;mov ah,3fh
;int 21h



;-------- Save Variables --------;

;Save_variables proc

;	call Clear_registers
	
;	mov al,Cannon_A_Life.object_life
;	mov Data_string[0],al
;	
;	mov al,Cannon_A_Life.x
;	mov Data_string[1],al
;
;	mov al,Cannon_A_Life.y
;	mov Data_string[2],al
;
;	mov al,Cannon_B_Life.object_life
;	mov Data_string[3],al
;	
;	mov al,Cannon_B_Life.x
;	mov Data_string[4],al
;
;	mov al,Cannon_B_Life.y
;	mov Data_string[5],al
;
;	mov al,COAL_MAN_Life.object_life
;	mov Data_string[6],al
;	
;	mov al,COAL_MAN_Life.x
;	mov Data_string[7],al
;
;	mov al,COAL_MAN_Life.y
;	mov Data_string[8],al
;
;	mov al,Cannon_A.x
;	mov Data_string[9],al
;	
;	mov al,Cannon_A.y
;	mov Data_string[10],al
;
;	mov al,Cannon_A.color
;	mov Data_string[11],al
;
;	mov al,Cannon_B.x
;	mov Data_string[12],al
;	
;	mov al,Cannon_B.y
;	mov Data_string[13],al
;
;	mov al,Cannon_B.color
;	mov Data_string[14],al
;
;	mov al,COAL_MAN.x
;	mov Data_string[15],al
;	
;	mov al,COAL_MAN.y
;	mov Data_string[16],al
;
;	mov al,COAL_MAN.color
;	mov Data_string[17],al
;	
;	mov al,Objects_character
;	mov Data_string[18],al
;
;	mov al,Cannon_A_row
;	mov Data_string[19],al
;
;	mov al,Cannon_A_column
;	mov Data_string[20],al
;	
;	mov al,Cannon_B_row
;	mov Data_string[21],al
;
;	mov al,Cannon_B_column
;	mov Data_string[22],al
;
;	mov al,COAL_MAN_row
;	mov Data_string[23],al
;
;	mov al,COAL_MAN_column
;	mov Data_string[24],al
;
;	mov al,row
;	mov Data_string[25],al
;
;	mov al,column
;	mov Data_string[26],al
;
;	mov al,character
;	mov Data_string[27],al
;
;	mov al,bool_A
;	mov Data_string[28],al
;
;	mov al,bool_B
;	mov Data_string[29],al
;
;	mov al,bool_C
;	mov Data_string[30],al
;
;	mov al,bool_mouse
;	mov Data_string[31],al
;	
;	push Mouse_click_bool
;	pop ax
;	mov Data_string[32],al
;
;	mov al,bool_mouse
;	mov Data_string[31],al
;
;	mov al,bool_mouse
;	mov Data_string[31],al
;
;	mov al,bool_mouse
;	mov Data_string[31],al
;	



;RET
;Save_variables endp












;-------- Main --------;

main proc

	mov ax,@data	;Moving address of data segment to data segment register 
	mov ds,ax
	
;	********************************************************************************************

		call Display_screen		;Display graphic screen
		
		call Initial_Interface
		call Sound_Initial
		
		call Clear_registers
		mov cx,003Fh
		mov dx,0FFFFh
		mov ah,86h
		int 15h
		call Clear_registers

		call Display_screen		;Display graphic screen

		call Select_screen
		
		Select_weapon:
			mov ah,01h
			int 16h
			mov dh,ah
			cmp dh,25h
			je Keyboard_selected
			jmp Not_selected
			
			Keyboard_selected:
				mov bool_weapon,0
				call Select_screen_keyboard
				jmp Not_selected_either
			
			Not_selected:
			
			mov ah,0ch
			int 21h

			mov ax,3
			int 33h
			cmp bx,1
			je Mouse_selected
			jmp Not_selected_either

			Mouse_selected:
				mov bool_weapon,1
				call Select_screen_mouse
			
			Not_selected_either:

			mov ah,0ch
			int 21h

			cmp bool_weapon,3
			je Select_weapon

		call Display_screen		;Display graphic screen

;	********************************************************************************************
	
	Wrong_input:

	call Change_Difficulty
	
	mov ah,00h
	int 16h
	
	cmp ah,02h
	je Easy_mode

	cmp ah,03h
	je Medium_mode

	cmp ah,04h
	je Hard_mode
	
	mov ah,0ch
	int 21h

	jmp Wrong_input

	Easy_mode:
		call Display_screen
		call Lives_column
		
		mov CA_mov_var,1
		mov CB_mov_var,1
		
		mov CA_bullet_var,1
		mov CB_bullet_var,1

		mov Cannon_A_Life.object_life, 7
		mov Cannon_A_Life.x, 5
		mov Cannon_A_Life.y, 65
		mov Cannon_A_Life.color, 150

		mov Cannon_B_Life.object_life, 7
		mov Cannon_B_Life.x, 8
		mov Cannon_B_Life.y, 65
		mov Cannon_B_Life.color, 150

		mov COAL_MAN_Life.object_life, 10
		mov COAL_MAN_Life.x, 11
		mov COAL_MAN_Life.y, 65
		mov COAL_MAN_Life.color, 150
		
		call Display_Lives
		jmp skip_it

	Medium_mode:
		call Display_screen
		call Lives_column

		mov CA_mov_var,1
		mov CB_mov_var,2
		
		mov CA_bullet_var,2
		mov CB_bullet_var,1

		mov Cannon_A_Life.object_life, 7
		mov Cannon_A_Life.x, 5
		mov Cannon_A_Life.y, 65
		mov Cannon_A_Life.color, 150

		mov Cannon_B_Life.object_life, 7
		mov Cannon_B_Life.x, 8
		mov Cannon_B_Life.y, 65
		mov Cannon_B_Life.color, 150

		mov COAL_MAN_Life.object_life, 7
		mov COAL_MAN_Life.x, 11
		mov COAL_MAN_Life.y, 65
		mov COAL_MAN_Life.color, 150
		
		call Display_Lives
		jmp skip_it

	Hard_mode:
		call Display_screen
		call Lives_column

		mov CA_mov_var,2
		mov CB_mov_var,2

		mov CA_bullet_var,2
		mov CB_bullet_var,2

		mov Cannon_A_Life.object_life,10
		mov Cannon_A_Life.x, 5
		mov Cannon_A_Life.y, 65
		mov Cannon_A_Life.color, 150

		mov Cannon_B_Life.object_life, 10
		mov Cannon_B_Life.x, 8
		mov Cannon_B_Life.y, 65
		mov Cannon_B_Life.color, 150

		mov COAL_MAN_Life.object_life, 7
		mov COAL_MAN_Life.x, 11
		mov COAL_MAN_Life.y, 65
		mov COAL_MAN_Life.color, 150
		
		call Display_Lives

	skip_it:		
		mov Cannon_A_row,0
		mov Cannon_A_column,6

		mov Cannon_B_row,0
		mov Cannon_B_column,40

		mov COAL_MAN_row,15
		mov COAL_MAN_column,25
		
		mov Bullet_A.x,2
		mov Bullet_A.y,13	
		mov Bullet_A.color,150
		
		mov Bullet_B.x,2
		mov Bullet_B.y,46
		mov Bullet_B.color,150
		
		mov Bullet_C.x,16
		mov Bullet_C.y,26
		mov Bullet_C.color,150
		
		mov ax,1	;Mouse Mode function call
		int 33h		;Interrupt

;	********************************************** MAIN DISPLAY FUNCTION *************************************************	;

		call Clear_registers
		call Display_Cannon_A
		call Display_Cannon_B
		call Display_COAL_MAN
		call Clear_registers
		
		call Sound_Fire_start

	Main_Display_function:

		call Clear_registers
		call Background_color

	;	*************************************************
		
		cmp COAL_MAN_Life.object_life,0
		jbe GAME_OVER

	;	*************************************************

		cmp Cannon_A_Life.object_life,0
		jbe Cannon_A_destroyed

	;	*************************************************

		call Move_Cannon_A
		call Clear_registers
		call Display_Cannon_A
		
	;	*************************************************

		call Shoot_Bullet_A
		call Clear_registers
		call Move_Bullet_A
		mov al,CA_bullet_var
		add Bullet_A.x,al

	;	*************************************************

		call Bullet_damage_A

	;	*************************************************
		
	Cannon_A_destroyed:

		cmp Counter_var,55
		jne Canon_B_missed
		
			cmp Cannon_B_Life.object_life,0
			jbe Cannon_B_destroyed

			call Move_Cannon_B		
			call Clear_registers
			call Display_Cannon_B
			
		;	*************************************************

			call Shoot_Bullet_B
			call Clear_registers
			call Move_Bullet_B
			mov al,CB_bullet_var
			add Bullet_B.x,al

		;	*************************************************

			call Bullet_damage_B
			
		;	*************************************************

		Cannon_B_destroyed:
			jmp Counter_missed
		
		Canon_B_missed:
			inc Counter_var
			
		Counter_missed:
		
		cmp Cannon_A_Life.object_life,0
		jbe Check_Cannon_B_Life
		jmp Cannon_A_alive
		
		Check_Cannon_B_Life:
			cmp Cannon_B_Life.object_life,0
			jbe GAME_WIN
			
	Cannon_A_alive:
	
	;	*************************************************

		cmp bool_weapon,0
		je Keyboard_weapon
		jmp Not_keyboard
		
		Keyboard_weapon:
			call Keyboard_Movement
			call Display_COAL_MAN
												
			call Shoot_Bullet_C_keyboard
			call Move_Bullet_C
			dec Bullet_C.x
	
	;	*************************************************
		Not_keyboard:

		cmp bool_weapon,1
		je Mouse_weapon
		jmp Not_mouse
		
		Mouse_weapon:
			call Mouse_Movement
			mov Mouse_click_bool,bx
			call Display_COAL_MAN
		
	;	*************************************************
		
		call Move_bullet_via_mouse

	;	*************************************************
		Not_mouse:		
		
		cmp Cannon_A_Life.object_life,0
		jbe Cannon_A_finished
			
			call Bullet_damage_COAL_A

		Cannon_A_finished:

		cmp Cannon_B_Life.object_life,0
		jbe Cannon_B_finished
			
			call Bullet_damage_COAL_B

		Cannon_B_finished:
		
	;	*************** Display Score ************************

		mov cx, 1
		mov ah, 02h
		mov dh, 14	; row
		mov dl, 72	; column
		int 10h
		
		call Output_score

	;	*************** TIMER ************************
	
		call Clear_registers
		mov cx,00h
		mov dx,07530h
		mov ah,86h
		int 15h
		
		jmp Main_Display_function
	
		GAME_WIN:			
			call Sound_Win
			
			Win_again:
				mov COAL_MAN_row,15
				mov COAL_MAN_column,25
				mov bool_C,0

				Variable_reset:

					call Clear_registers
					call Background_color
				
					mov ah,0
					mov al,0
					mov bh,0
					mov bl,130
					mov cx,lengthof Win_msg
					mov dl,36
					mov dh,11
					push cs
					pop es
					mov bp,offset Win_msg
					mov ah,13h
					int 10h
					jmp this_msg_4
					Win_msg db "You Win! :-)"
					this_msg_4:
					
					mov COAL_MAN_Life.object_life, 10
					mov COAL_MAN_Life.x, 11
					mov COAL_MAN_Life.y, 65
					mov COAL_MAN_Life.color, 150
								
					call Display_COAL_MAN_life
					
					call Move_Random_Robot
					call Shoot_Bullet_C_keyboard
					call Move_Bullet_C
					dec Bullet_C.x
					
					call Clear_registers
					mov cx,00h
					mov dx,01FFFh
					mov ah,86h
					int 15h

				jmp Variable_reset

		GAME_OVER:
			call Sound_Lose

			Over_again:
				call Clear_registers
				call Background_color
				
				mov ah,0
				mov al,0
				mov bh,0
				mov bl,130
				mov cx,lengthof Lose_msg
				mov dl,36
				mov dh,14
				push cs
				pop es
				mov bp,offset Lose_msg
				mov ah,13h
				int 10h
				jmp this_msg_5
				Lose_msg db "You Lose! :-("
				this_msg_5:

				mov Cannon_A_Life.object_life, 10
				mov Cannon_A_Life.x, 5
				mov Cannon_A_Life.y, 65
				mov Cannon_A_Life.color, 150

				mov Cannon_B_Life.object_life, 10
				mov Cannon_B_Life.x, 8
				mov Cannon_B_Life.y, 65
				mov Cannon_B_Life.color, 150

				call Display_Lives
				
				call Move_Cannon_A
				call Clear_registers
				call Display_Cannon_A
				
				call Shoot_Bullet_A
				call Clear_registers
				
				cmp Bullet_A.x,2
				je Sound_shoot
				jmp No_sound_shoot
				
				Sound_shoot:
					call Sound_Fire_Bullet
				
				No_sound_shoot:
				
				call Move_Bullet_A
				inc Bullet_A.x			
				
				call Move_Cannon_B		
				call Clear_registers
				call Display_Cannon_B
				
				call Shoot_Bullet_B
				call Clear_registers

				cmp Bullet_B.x,2
				je Sound_shoot_B
				jmp No_sound_shoot_B
				
				Sound_shoot_B:
					call Sound_Fire_Bullet
				
				No_sound_shoot_B:

				call Move_Bullet_B
				inc Bullet_B.x
				inc Bullet_B.x

				call Clear_registers
				mov cx,01h
				mov dx,01FFFh
				mov ah,86h
				int 15h
				
				jmp Over_again
	
	Exit_code:
		mov ax,4c00h
		int 21h

main endp
end main