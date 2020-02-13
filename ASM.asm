	    list	p=pic16f870
	    __config	3d3ah
porta	    equ		05h
trisa	    equ		05h
trisc	    equ		07h
portc	    equ		07h	    
portb	    equ		06h
trisb	    equ		06h
status	    equ		03h
pcl	   	    equ		02h
Reg_1	    equ		21h
Reg_2	    equ		22h
Reg_3	    equ		23h
numb1	    equ		24h
numb2	    equ		25h	    
numb3	    equ		26h	    
numb4	    equ		27h
tre	   	    equ		28h
tre2		equ		47h
cas	    	equ		29h
nado	    equ		30h
sec1	    equ		31h
sec2	    equ		32h	
swit4	    equ		33h
swit3	    equ		34h
swit2	    equ		35h
swit1	    equ		36h	  
One_Wire_Byte equ       37h
Counter     equ         38h
TempL       equ         39h
TempH       equ         40h
Temp        equ         41h
Ind_Znak    equ         42h
Ind_100     equ         43h
Ind_10      equ         44h
Ind_1       equ         45h
TMP0        equ         46h
DQ          equ         4
PORTDQ      equ         portb
TRISDQ      equ         trisb
ADCON1		equ			9Fh	
ADCON0		equ			1fh 
tre3		equ			48h
ll			equ			49h
reler		equ			50h
hod			equ			51h
  org		0000h
	    
	    bsf	status,5
	    movlw	b'00010000';?????????
	    movwf	trisb
	    movlw	b'00000000'
	    movwf		trisc
	    movlw	b'00001110'
	    movwf	trisa	;?????????
		
		movlw	b'00000111'
		movwf	ADCON1
	    bcf		status,5
		
		movlw	b'11000000'
		movwf	ADCON0

		movlw	.2
		movwf	nado

		movlw	.6
		movwf	hod
		bcf		portb,7
		
		
		goto	beggg


tablica     addwf       pcl,1;
           retlw       b'00000010';0   COMMAN ANODE
           retlw       b'11011010';1   an
           retlw       b'01000100';2   an
           retlw       b'01010000';3   an
           retlw       b'10011000';4   an
           retlw       b'00110000';5   an
           retlw       b'00100000';6   an
           retlw       b'01011010';7   an
           retlw       b'00000000';8   an
           retlw       b'00010000';9   an
           retlw       b'11111111';+
           retlw       b'10111111';-




beggg		clrf	numb1
		clrf	numb2
		clrf	numb3
		clrf	numb4

		clrf	swit1
		clrf	swit3
		movlw	.1
		movwf	swit2
		clrf	swit4


;==============================
	
begin  	    movlw	.202
			movwf	tre3

beg3		movlw	.6
			movwf	tre2

beg2		movlw	.61	
			movwf	tre

beg			movf	swit1,0
			call	tablica	
			movwf	portc
			bcf		portb,3
			call	delay
			bsf		portb,3

			movf	swit2,0
			call	tablica	
			movwf	portc			
			bcf		portb,2
			call	delay	
			bsf		portb,2

			movf	swit3,0			
			call	tablica	
			movwf	portc
			bcf		portb,1
			call	delay
			bsf		portb,1

			movf	swit4,0
			call	tablica	
			movwf	portc
			bcf		portb,0
			call	delay	
			bsf		portb,0
		
			decfsz	tre,1
			goto	beg

			decfsz	tre2,1
			goto	beg2
		
;-------------------------------------------------
;=============KNOPKA_KINEC========================	
mum			btfsc	porta,2
			goto	ff

			movlw	.2
			subwf	swit3,0
			btfsc	status,2		
			goto	re

			incf	swit4,1
			movlw	.10
			subwf	swit4,0
			btfss	status,2
			goto	ff
			incf	swit3,1
			clrf	swit4
	
			movlw	.3
			subwf	swit3,0
			btfss	status,2
			goto	ff
			clrf	swit3
			goto	ff

re			incf	swit4,1
			movlw	.4
			subwf	swit4,0
			btfss	status,2
			goto	ff
			clrf	swit4
			clrf	swit3
;=============KNOPKA_KINEC========================
;-------------------------------------------------
;-------------------------------------------------
;=============KNOPKA_POCATOK======================
ff			btfsc	porta,1
			goto	f1

			decfsz	reler,0
			incf	reler,1

			movlw	.2
			subwf	swit1,0
			btfsc	status,2		
			goto	re2

			incf	swit2,1
			movlw	.10
			subwf	swit2,0
			btfss	status,2
			goto	f1
			incf	swit1,1
			clrf	swit2
	
			movlw	.3
			subwf	swit1,0
			btfss	status,2
			goto	f1
			clrf	swit1
			goto	f1

re2			incf	swit2,1
			movlw	.4
			subwf	swit2,0
			btfss	status,2
			goto	f1
			clrf	swit1
			clrf	swit2
;=============KNOPKA_POCATOK========================
;-------------------------------------------------
		

f1		call	rele

			movlw	.6
			subwf	hod,0
			btfsc	status,2
			goto	$+3
			incf	hod,1
			goto	$+3
			btfss	porta,3
			goto	perehid1
			decfsz	tre3,1
			goto	beg3



			call	narah
			goto	begin
		


;**************************************************
;**************************************************
;**************************************************
;**************************************************
;**************************************************
;**************************************************
;**************************************************
temmpp		nop
temmp		movlw		.202
			movwf		tre3
			
hta			movlw		.12
			movwf		tre2
			call        One_Wire_Init
            movlw       H'CC'
            call        One_Wire_Write_Byte
            movlw       H'44'
            call        One_Wire_Write_Byte            
            call        delay_432us          
            call        One_Wire_Init
            movlw       H'CC'
            call        One_Wire_Write_Byte
            movlw       H'BE'
            call        One_Wire_Write_Byte
            call        One_Wire_Read_Byte
            movwf       TempL
            call        One_Wire_Read_Byte
            movwf       TempH
            call        One_Wire_Convert_Temp
            call        Opredelenie_Znaka
            call        Convert_Bin_To_Ind
			

  ht        movlw       .59
            movwf       tre
            call        Din_Indication		
            decfsz      tre,1
            goto        $-2
			decfsz      tre2,1
            goto        ht
			
			call	rele

			movlw	.6
			subwf	hod,0
			btfsc	status,2
			goto	$+3
			incf	hod,1
			goto	$+3
			btfss	porta,3
			goto	perehid3
            decfsz		tre3,1
			goto		hta
			call		narah
			goto       temmp

Din_Indication
			bsf	portb,1
			bsf	portb,2
	    movf        Ind_1,0;8
            call        tablica
            movwf       portc	    
	    bcf		portb,1
            call        delay;
            bsf         portb,1;        NPN

;---------------------------------------------------------
            movf        Ind_10,0;4
            call        tablica
            movwf       portc
	 
            bcf         portb,2;        NPN
            call        delay;
            bsf         portb,2;        NPN		
		
;-----------------------------------------------------
          
            return
Opredelenie_Znaka
            clrf        Ind_Znak;0
            movf        Temp,0
            btfss       Temp,7
            return
            incf        Ind_Znak,1
            comf        Temp,0
            addlw       .1
            return

Convert_Bin_To_Ind
            movwf       TMP0
            clrf        Ind_100
            clrf        Ind_10
            clrf        Ind_1
Convert_100 movlw       .100
            subwf       TMP0,0
            btfss       status,0
            goto        Convert_10
            incf        Ind_100,1
            movwf       TMP0
            goto        Convert_100
Convert_10  movlw       .10
            subwf       TMP0,0
            btfss       status,0
            goto        Convert_1
            incf        Ind_10,1
            movwf       TMP0
            goto        Convert_10
Convert_1   movf        TMP0,0
            movwf       Ind_1
            return

One_Wire_Init
            bcf         PORTDQ,DQ; PORTA,0
            bsf         status,5
            bcf         TRISDQ,DQ; TRISA,0
            bcf         status,5
            call        delay_500us
            bsf         status,5
            bsf         TRISDQ,DQ; TRISA,1
            bcf         status,5
            call        delay_500us
            return

One_Wire_Write_Byte
            movwf       One_Wire_Byte
            movlw       .8
            movwf       Counter
One_Wire_Write_Bit
            bcf         PORTDQ,DQ; PORTA,0
            bsf         status,5
            bcf         TRISDQ,DQ; TRISA,0
            bcf         status,5
            call delay_2us
            rrf         One_Wire_Byte
            bsf         status,5
            btfsc       status,0
            bsf         TRISDQ,DQ
            bcf         status,5
            call        delay_60us
            bsf         status,5
            bsf         TRISDQ,DQ; TRISA,0
            bcf         status,5
            decfsz      Counter,1
            goto        One_Wire_Write_Bit
            return

One_Wire_Read_Byte
            movlw       .8
            movwf       Counter
One_Wire_Read_Bit
            bcf         PORTDQ,DQ; PORTA,0
            bsf         status,5
            bcf         TRISDQ,DQ; TRISA,0
            bcf         status,5
            call delay_2us
            call delay_2us
            call delay_2us
            bsf         status,5
            bsf         TRISDQ,DQ; TRISA,1
            bcf         status,5
            call delay_2us
            call delay_2us
            bcf         status,0
            btfsc       PORTDQ,DQ
            bsf         status,0
            rrf         One_Wire_Byte
            call        delay_60us
            decfsz      Counter,1
            goto        One_Wire_Read_Bit
            movf        One_Wire_Byte,0
            return

One_Wire_Convert_Temp
            movlw       b'11110000'
            andwf       TempL,0;xxxxxxxx;w=xxxx0000
            movwf       Temp;xxxx0000
            movlw       b'00001111'
            andwf       TempH,0;yyyyyyyy;w=0000yyyy
            iorwf       Temp,1;xxxxyyyy
            swapf       Temp,1;yyyyxxxx
            return

;---
delay_60us  movlw       .98
            movwf       Reg_1
            decfsz      Reg_1,F
            goto        $-1
            nop
            nop
            return
;===
delay_500us
			MOVLW		.5
			movwf		Reg_2
jh            movlw       .165
            movwf       Reg_1
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
			goto		jh
	
            nop
            return

;===
delay_432us movlw		.3
			movwf		Reg_2
HH			movlw       .200
            movwf       Reg_1
            decfsz      Reg_1,F
            goto        $-1
			decfsz		Reg_2,1
			GOTO		HH
            nop
            nop
            return

delay_1s    movlw       .173
            movwf       Reg_1
            movlw       .19
            movwf       Reg_2
            movlw       .6
            movwf       Reg_3
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop
            return
delay_2us	movlw		.1
			movwf		Reg_1
			decfsz		Reg_1,1
			goto		$-1
		
			nop
	
			return


;******************HOUR*********************
;******************HOUR*********************
;******************HOUR*********************


time  	    movlw	.202
			movwf	tre3

b2eg3		movlw	.6
			movwf	tre2

b2eg2		movlw	.61	
			movwf	tre
b2eg		movf	numb1,0
			call	tablica	
			movwf	portc
			bcf		portb,3
			call	delay
			bsf		portb,3

			movf	numb2,0
			call	tablica	
			movwf	portc			
			bcf		portb,2
			call	delay	
			bsf		portb,2

			movf	numb3,0			
			call	tablica	
			movwf	portc
			bcf		portb,1
			call	delay
			bsf		portb,1

			movf	numb4,0
			call	tablica	
			movwf	portc
			bcf		portb,0
			call	delay	
			bsf		portb,0	
		
			decfsz	tre,1
			goto	b2eg
			
			
			decfsz	tre2,1
			goto	b2eg2

			call	rele
;-------------------------------------------------
;=============KNOPKA_KINEC========================	
gtr			btfsc	porta,2
			goto	ku

			
			incf	numb4,1
			movlw	.10
			subwf	numb4,0
			btfss	status,2
			goto	ku
			incf	numb3,1
			clrf	numb4
	
			movlw	.6
			subwf	numb3,0
			btfss	status,2
			goto	ku
			clrf	numb3
			
;=============KNOPKA_KINEC========================
;-------------------------------------------------
;-------------------------------------------------	
;-------------------------------------------------
;=============KNOPKA_POCATOK======================
ku			btfsc	porta,1
			goto	lil

			movlw	.2
			subwf	numb1,0
			btfsc	status,2		
			goto	lol

			incf	numb2,1
			movlw	.10
			subwf	numb2,0
			btfss	status,2
			goto	lil
			incf	numb1,1
			clrf	numb2
	
			movlw	.3
			subwf	numb1,0
			btfss	status,2
			goto	lil
			clrf	numb1
			goto	lil

lol			incf	numb2,1
			movlw	.4
			subwf	numb2,0
			btfss	status,2
			goto	lil
			clrf	numb1
			clrf	numb2
;=============KNOPKA_POCATOK======================
;-------------------------------------------------
	

lil			movlw	.6
			subwf	hod,0
			btfsc	status,2
			goto	$+3
			incf	hod,1
			goto	$+3
			btfss	porta,3
			goto	perehid2
			decfsz	tre3,1
			goto	b2eg3
			call	narah
			goto	time
			

;--------------------------------------------------

narah			movlw	.9
			subwf	numb4,0
			btfsc	status,2
			goto	n3
				
			incf		numb4,1
			return

n3			clrf		numb4  
			movlw		.5
			subwf		numb3,0	
			btfsc		status,2
			goto		n2
			incf		numb3,1
			return


n2			clrf		numb3
			movf		numb1,0
			sublw		.2
			btfsc		status,2
			goto		n1v1
			movlw		.9
			subwf		numb2,0	
			btfsc		status,2
			goto		n1
			incf		numb2,1
			return



n1			clrf		numb2
			movlw		.2
			subwf		numb1,0	
			btfsc		status,2
			goto		n0
			incf		numb1,1
			return

n0			clrf		numb1
			return
			
n1v1		clrf		numb3
			incf		numb2,1
			movlw		.4
			subwf		numb2,0	
			btfss		status,2
			return			
			clrf		numb2
			goto		n0
			


;-------------------------------------------
;-------------------------------------------
;******************HOUR*********************
;******************HOUR*********************
;******************HOUR*********************

			


delay
            movlw       .75
            movwf       Reg_1
            movlw       .2
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3



            return

perehid1	movlw		.1
			movwf		tre
			movwf		tre2
			clrf		hod
			goto		b2eg

perehid2	movlw		.1
			movwf		tre
			movwf		tre2
			clrf		hod
			goto		temmp	


perehid3	movlw		.1
			movwf		tre
			movwf		tre2
			clrf		hod
			goto		beg

		
rele		btfsc		portb,7	
			goto		htre	
			
			movf	numb1,0
			subwf	swit1,0
			btfss	status,2
			return

			movf	numb2,0
			subwf	swit2,0
			btfss	status,2
			return
			bsf		portb,7
			
			return		

htre		movf	numb1,0
			subwf	swit3,0
			btfss	status,2
			return

			movf	numb2,0
			subwf	swit4,0
			btfss	status,2
			return
			bcf		portb,7
			return				

            end
;======================================





	    	 