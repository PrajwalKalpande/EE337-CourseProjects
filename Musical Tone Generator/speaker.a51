LCD_DATA EQU P2		;LCD Data port
LCD_RS EQU P0.0		;LCD Register Select
LCD_RW EQU P0.1		;LCD Read/Write
LCD_EN EQU P0.2		;LCD Enable

ORG 0H
LJMP MAIN

ORG 100H
 
;------------------------LCD Initialisation Routine------------------------
LCD_INIT:
	MOV LCD_DATA, #38H		;Function set: 2 Line, 8-bit, 5x7 dots
	CLR LCD_RS				;Selected command register
	CLR LCD_RW				;We are writing in instruction register
	SETB LCD_EN				;Enable H->L
	ACALL DELAY
	CLR LCD_EN
	ACALL DELAY
	
	MOV LCD_DATA, #0CH		;Display on, Curson off
	CLR LCD_RS				;Selected instruction register
	CLR LCD_RW				;We are writing in instruction register
	SETB LCD_EN				;Enable H->L
	ACALL DELAY
	CLR LCD_EN
	ACALL DELAY
	
	MOV LCD_DATA, #01H		;Clear LCD
	CLR LCD_RS				;Selected command register
	CLR LCD_RW				;We are writing in instruction register
	SETB LCD_EN				;Enable H->L
	ACALL DELAY
	CLR LCD_EN
	ACALL DELAY
	
	MOV LCD_DATA, #06H		;Entry mode, auto increment with no shift
	CLR LCD_RS				;Selected command register
	CLR LCD_RW				;We are writing in instruction register
	SETB LCD_EN				;Enable H->L
	ACALL DELAY
	CLR LCD_EN
	ACALL DELAY
RET
;------------------------LCD Command Sending Routine------------------------
LCD_COMMAND:
	MOV LCD_DATA, A			;Move the command to LCD port
	CLR LCD_RS				;Selected data register
	CLR LCD_RW				;We are writing
	SETB LCD_EN				;Enable H->L
	ACALL DELAY
	CLR LCD_EN
	ACALL DELAY
RET
;------------------------LCD Data Sending Routine------------------------
LCD_SENDDATA:
	MOV LCD_DATA, A			;Move the command to LCD port
	SETB LCD_RS				;Selected data register
	CLR LCD_RW				;We are writing
	SETB LCD_EN				;Enable H->L
	ACALL DELAY
	CLR LCD_EN
	ACALL DELAY
RET
;------------------------LCD Data Sending Routine------------------------
LCD_SENDSTRING:
	PUSH 0E0H
	LCD_SENDSTRING_LOOP:
		CLR A						;clear Accumulator for any previous data
		MOVC A, @A+DPTR				;load the first character in accumulator
		JZ EXIT						;go to exit if zero
		ACALL LCD_SENDDATA			;send first char
		INC DPTR					;increment data pointer
		SJMP LCD_SENDSTRING_LOOP	;jump back to send the next character
	EXIT: POP 0E0H
RET

ORG 200H
;--------------------------------LCD Printing--------------------------------
 
DISPLAY_MSG:
	ACALL LCD_INIT
	ACALL DELAY
	
	MOV A, #80H						;setting cursor position in first row
	ACALL LCD_COMMAND

	MOV DPTR, #roll_string					;to print string
	ACALL LCD_SENDSTRING
	 
RET

DELAY_N1:
    MOV TH0, #0EEH
    MOV TL0, #3FH 
    SETB TR0 
AGAIN1:JNB TF0,AGAIN1 
    CLR TR0
    CLR TF0 
RET 


N1: 
    ;f in  = 2Mhz 
    ; fn1 = 1/220 => total cyles needed  = fin * Tn1 = 9090 
    ; load TH TL with 65536 - 45 45 = EE3F
MOV R0,#28 
MOV TMOD,#11H 

HERE1:MOV TH1,#3CH
MOV TL1,#0B0H 
SETB TR1 

BACK1:CPL P0.7
    ACALL DELAY_N1
   CPL P0.7 
    ACALL DELAY_N1

    JNB TF1, BACK1 

    CLR TR1
    CLR TF1 
    DJNZ R0,HERE1 

RET 


DELAY_N2:
    MOV TH0, #0F0H
    MOV TL0, #30H 
    SETB TR0 
AGAIN2:JNB TF0,AGAIN2
    CLR TR0
    CLR TF0 
RET 

N2: 
    ;f in  = 2Mhz 
    ; fn1 = 1/247=> total cyles needed  = fin * Tn1 = 8096
    ; load TH TL with 65536 - 8096/2 = E060
MOV R0,#28
MOV TMOD,#11H 
HERE2:MOV TH1,#3CH
MOV TL1,#0B0H 
SETB TR1 

BACK2:CPL P0.7
    ACALL DELAY_N2
    CPL P0.7 
    ACALL DELAY_N2

    JNB TF1, BACK2

    CLR TR1
    CLR TF1 
    DJNZ R0,HERE2

RET 


DELAY_N3:
    MOV TH0, #0F2H
    MOV TL0, #0B7H 
    SETB TR0 
AGAIN3:JNB TF0,AGAIN3
    CLR TR0
    CLR TF0 
RET 
N3: 
    ;f in  = 2Mhz 
    ; fn1 = 1/247=> total cyles needed  = fin * Tn1 = 6802 
    ; load TH TL with 65536 - 6802/2 = F2B7
MOV R0,#28
MOV TMOD,#11H 
HERE3:MOV TH1,#3CH
MOV TL1,#0B0H 
SETB TR1 

BACK3:CPL P0.7
    ACALL DELAY_N3
    CPL P0.7 
    ACALL DELAY_N3

    JNB TF1, BACK3

    CLR TR1
    CLR TF1 
    DJNZ R0,HERE3

RET 


DELAY_N4:
    MOV TH0, #0F5H
    MOV TL0, #72H 
    SETB TR0 
AGAIN4:JNB TF0,AGAIN4
    CLR TR0
    CLR TF0 
RET 
N4: 
    ;f in  = 2Mhz 
    ; fn1 = 1/247=> total cyles needed  = fin * Tn1 = 6802 
    ; load TH TL with 65536 - 5404/2 = F572
MOV R0,#38
MOV TMOD,#11H 
HERE4:MOV TH1,#3CH
MOV TL1,#0B0H 
SETB TR1 

BACK4:CPL P0.7
    ACALL DELAY_N4
    CPL P0.7 
    ACALL DELAY_N4

    JNB TF1, BACK4

    CLR TR1
    CLR TF1 
    DJNZ R0,HERE4

RET 

 
DELAY_N5:
    MOV TH0, #0F4H
    MOV TL0, #2AH 
    SETB TR0 
AGAIN5:JNB TF0,AGAIN5
    CLR TR0
    CLR TF0 
RET 
N5: 
    ;f in  = 2Mhz 
    ; fn1 = 1/247=> total cyles needed  = fin * Tn1 = 6060
    ; load TH TL with 65536 - 3030 = F42A
MOV R0,#38
MOV TMOD,#11H 
HERE5:MOV TH1,#3CH
MOV TL1,#0B0H 
SETB TR1 

BACK5:CPL P0.7
    ACALL DELAY_N5
    CPL P0.7 
    ACALL DELAY_N5

    JNB TF1, BACK5

    CLR TR1
    CLR TF1 
    DJNZ R0,HERE5

RET 

SILENCE:
    CLR P0.7 
    ACALL DELAY_500ms
RET 

       






 
  
    

;--------------------------------Strings--------------------------------
roll_string:
	DB "ROLLING TIME", 00H
 
 
 
MAIN:
	MOV P0, #0H
	MOV P1, #0H
	MOV P2, #0H
    BACK:	LCALL LCD_INIT			; initialising LCD
  LCALL DISPLAY_MSG
BACK6:  ACALL N1 
  ACALL N2 
    ACALL N3 
    ACALL  N2
    ACALL N4 
    ACALL SILENCE 
    ACALL N4 
    ACALL N5 
SJMP BACK6
 
;--------------------------------DELAY Routines--------------------------------
DELAY_500ms:
		 
		PUSH 1H
			MOV R1, #20
			AGAIN:
				ACALL DELAY_25ms
				DJNZ R1, AGAIN
		POP 1H
		 
	RET
	
DELAY_25ms:
		MOV TMOD, #10H // 3
		PUSH 0
		PUSH 1
		MOV R0,#50H
		MOV R1,#0C3H
		
		MOV A,#00H // 1
		CLR C // 1
		SUBB A,R0 //1 
		MOV 32H,A //1

		MOV A,#00H //1
		SUBB A,R1 //1
		MOV 33H,A //1

		MOV TL1, 32H //2
		MOV TH1, 33H //2
		SETB TR1 //1
		LOOP: JNB TF1, LOOP //2 
		CLR TR1 //1
		CLR TF1 //1
		POP 1
		POP 0
	RET //2
//delay for LCD stuff
DELAY:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loop1:	 djnz r1, loop1
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret	

END