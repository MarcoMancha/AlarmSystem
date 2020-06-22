
;CodeVisionAVR C Compiler V3.39a Evaluation
;(C) Copyright 1998-2020 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega328P
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: Off
;Smart register allocation: Off

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega328P
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x08FF
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x3:
	.DB  0x3,0x3,0x3,0x2,0x2,0xC,0x0,0x8
	.DB  0x0,0x1,0x0,0x6
_0x22:
	.DB  0x1
_0x0:
	.DB  0x41,0x4C,0x41,0x52,0x4D,0x41,0x20,0x41
	.DB  0x43,0x54,0x49,0x56,0x41,0x0,0x43,0x4C
	.DB  0x41,0x56,0x45,0x3A,0x20,0x0,0x41,0x4C
	.DB  0x41,0x52,0x4D,0x41,0x0,0x44,0x45,0x53
	.DB  0x41,0x43,0x54,0x49,0x56,0x41,0x44,0x41
	.DB  0x0,0x41,0x4C,0x41,0x52,0x4D,0x41,0x20
	.DB  0x41,0x43,0x54,0x49,0x56,0x41,0x44,0x41
	.DB  0x0,0x43,0x41,0x4D,0x42,0x49,0x41,0x52
	.DB  0x20,0x43,0x4C,0x41,0x56,0x45,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _estatus
	.DW  _0x22*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x300

	.CSEG
;/*
; * sensor.c
; *
; * Created: 6/11/2020 8:29:24 PM
; * Authors: Marco Mancha - Ivett Nunez - Mayka Arizbeth
; */
;
;//Configure display
;#asm
    .equ __lcd_port=0x08
    .equ __lcd_EN=1
    .equ __lcd_RS=0
    .equ __lcd_D4=2
    .equ __lcd_D5=3
    .equ __lcd_D6=4
    .equ __lcd_D7=5
; 0000 0011 #endasm
;
;
;//Configure keypad
;#asm
    .equ __keypad_port=0x0B
    .equ __keypad_R1=0
    .equ __keypad_R2=1
    .equ __keypad_R3=2
    .equ __keypad_R4=3
    .equ __keypad_C1=6
    .equ __keypad_C2=5
    .equ __keypad_C3=4
; 0000 001E #endasm
;
;
;#include <stdio.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
;#include <io.h>
;#include <delay.h>
;#include <display.h>

	.CSEG
_SetupLCD:
; .FSTART _SetupLCD
	SBIW R28,12
	LDI  R24,12
	__GETWRN 22,23,0
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	RCALL __INITLOCB
	ST   -Y,R16
;	TableSetup -> Y+1
;	i -> R16
; 0000 0024     SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_RS
    SBI __lcd_port-1,__lcd_D4
    SBI __lcd_port-1,__lcd_D5
    SBI __lcd_port-1,__lcd_D6
    SBI __lcd_port-1,__lcd_D7
	LDI  R26,LOW(50)
	LDI  R27,0
	RCALL _delay_ms
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,12
	BRSH _0x6
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	MOV  R30,R16
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL _SendDataBitsLCD
	RCALL _PulseEn
	SUBI R16,-1
	RJMP _0x5
_0x6:
	LDI  R30,LOW(12)
	STS  _cursor,R30
	LDS  R26,_cursor
	RCALL _WriteComandLCD
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND
_PulseEn:
; .FSTART _PulseEn
    SBI __lcd_port,__lcd_EN  // EN=1;
    CBI __lcd_port,__lcd_EN // EN=0;
	RET
; .FEND
_SendDataBitsLCD:
; .FSTART _SendDataBitsLCD
	ST   -Y,R16
	MOV  R16,R26
;	dato -> R16
	SBRS R16,3
	RJMP _0x7
	SBI __lcd_port,__lcd_D7
	RJMP _0x8
_0x7:
	CBI __lcd_port,__lcd_D7
_0x8:
	SBRS R16,2
	RJMP _0x9
	SBI __lcd_port,__lcd_D6
	RJMP _0xA
_0x9:
	CBI __lcd_port,__lcd_D6
_0xA:
	SBRS R16,1
	RJMP _0xB
	SBI __lcd_port,__lcd_D5
	RJMP _0xC
_0xB:
	CBI __lcd_port,__lcd_D5
_0xC:
	SBRS R16,0
	RJMP _0xD
	SBI __lcd_port,__lcd_D4
	RJMP _0xE
_0xD:
	CBI __lcd_port,__lcd_D4
_0xE:
	JMP  _0x2080004
; .FEND
_WriteComandLCD:
; .FSTART _WriteComandLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	Comando -> R17
;	tempComando -> R16
	CBI __lcd_port,__lcd_RS
	RJMP _0x2080005
; .FEND
_CharLCD:
; .FSTART _CharLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	dato -> R17
;	tempdato -> R16
	SBI __lcd_port,__lcd_RS
_0x2080005:
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	MOV  R16,R30
	SWAP R16
	ANDI R16,0xF
	MOV  R26,R16
	RCALL _SendDataBitsLCD
	RCALL _PulseEn
	MOV  R30,R17
	ANDI R30,LOW(0xF)
	MOV  R16,R30
	MOV  R26,R16
	RCALL _SendDataBitsLCD
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	RCALL _PulseEn
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
_StringLCD:
; .FSTART _StringLCD
	RCALL __SAVELOCR3
	__PUTW2R 17,18
;	Mensaje -> R17,R18
;	i -> R16
	LDI  R16,LOW(0)
_0x10:
	MOV  R30,R16
	SUBI R16,-1
	LDI  R31,0
	ADD  R30,R17
	ADC  R31,R18
	LPM  R26,Z
	RCALL _CharLCD
	MOV  R30,R16
	LDI  R31,0
	ADD  R30,R17
	ADC  R31,R18
	LPM  R30,Z
	CPI  R30,0
	BRNE _0x10
	JMP  _0x2080003
; .FEND
;	Mensaje -> R19,R20
;	tiempo -> R17,R18
;	i -> R16
;	Mensaje -> R17,R18
;	i -> R16
_EraseLCD:
; .FSTART _EraseLCD
	LDI  R26,LOW(1)
	RCALL _WriteComandLCD
	RET
; .FEND
_MoveCursor:
; .FSTART _MoveCursor
	ST   -Y,R17
	ST   -Y,R16
	MOV  R16,R26
	LDD  R17,Y+2
;	x -> R17
;	y -> R16
	MOV  R30,R16
	LDI  R31,0
	SBIW R30,0
	BRNE _0x1B
	MOV  R26,R17
	SUBI R26,-LOW(128)
	RJMP _0x6C
_0x1B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1C
	MOV  R26,R17
	SUBI R26,-LOW(192)
	RJMP _0x6C
_0x1C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1D
	MOV  R26,R17
	SUBI R26,-LOW(148)
	RJMP _0x6C
_0x1D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1A
	MOV  R26,R17
	SUBI R26,-LOW(212)
_0x6C:
	RCALL _WriteComandLCD
_0x1A:
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2080002
; .FEND
;	NoCaracter -> R19
;	datos -> R17,R18
;	i -> R16
;#include <eeprom.h>
;
;void SetupKeypad()
; 0000 0028 {
_SetupKeypad:
; .FSTART _SetupKeypad
; 0000 0029     #asm
; 0000 002A         SBI __keypad_port-1,__keypad_R1 ;Renglón 1 de salida
        SBI __keypad_port-1,__keypad_R1 ;Renglón 1 de salida
; 0000 002B         SBI __keypad_port-1,__keypad_R2 ;Renglón 2 de salida
        SBI __keypad_port-1,__keypad_R2 ;Renglón 2 de salida
; 0000 002C         SBI __keypad_port-1,__keypad_R3 ;Renglón 3 de salida
        SBI __keypad_port-1,__keypad_R3 ;Renglón 3 de salida
; 0000 002D         SBI __keypad_port-1,__keypad_R4 ;Renglón 4 de salida
        SBI __keypad_port-1,__keypad_R4 ;Renglón 4 de salida
; 0000 002E         SBI __keypad_port,__keypad_C1   ;Pull-up en Columna 1
        SBI __keypad_port,__keypad_C1   ;Pull-up en Columna 1
; 0000 002F         SBI __keypad_port,__keypad_C2   ;Pull-up en Columna 2
        SBI __keypad_port,__keypad_C2   ;Pull-up en Columna 2
; 0000 0030         SBI __keypad_port,__keypad_C3   ;Pull-up en Columna 3
        SBI __keypad_port,__keypad_C3   ;Pull-up en Columna 3
; 0000 0031     #endasm
; 0000 0032 }
	RET
; .FEND
;
;#pragma warn-
;char LeeTeclado()
; 0000 0036 {
_LeeTeclado:
; .FSTART _LeeTeclado
; 0000 0037     #asm
; 0000 0038     Inicio:
    Inicio:
; 0000 0039         SBIS __keypad_port-2,__keypad_C1
        SBIS __keypad_port-2,__keypad_C1
; 0000 003A         RJMP BarridoC1
        RJMP BarridoC1
; 0000 003B         SBIS __keypad_port-2,__keypad_C2
        SBIS __keypad_port-2,__keypad_C2
; 0000 003C         RJMP BarridoC2
        RJMP BarridoC2
; 0000 003D         SBIS __keypad_port-2,__keypad_C3
        SBIS __keypad_port-2,__keypad_C3
; 0000 003E         RJMP BarridoC3
        RJMP BarridoC3
; 0000 003F         CLR R30    ;no hay tecla presionada
        CLR R30    ;no hay tecla presionada
; 0000 0040         RJMP Fin
        RJMP Fin
; 0000 0041      BarridoC1:
     BarridoC1:
; 0000 0042         LDI R30,'1'
        LDI R30,'1'
; 0000 0043         SBI __keypad_port,__keypad_R2   ;R2=1
        SBI __keypad_port,__keypad_R2   ;R2=1
; 0000 0044         SBI __keypad_port,__keypad_R3   ;R3=1
        SBI __keypad_port,__keypad_R3   ;R3=1
; 0000 0045         SBI __keypad_port,__keypad_R4   ;R4=1
        SBI __keypad_port,__keypad_R4   ;R4=1
; 0000 0046         NOP
        NOP
; 0000 0047         SBIS __keypad_port-2,__keypad_C1
        SBIS __keypad_port-2,__keypad_C1
; 0000 0048         RJMP Fin
        RJMP Fin
; 0000 0049         LDI R30,'4'
        LDI R30,'4'
; 0000 004A         SBI __keypad_port,__keypad_R1   ;R1=1
        SBI __keypad_port,__keypad_R1   ;R1=1
; 0000 004B         CBI __keypad_port,__keypad_R2   ;R2=0
        CBI __keypad_port,__keypad_R2   ;R2=0
; 0000 004C         NOP
        NOP
; 0000 004D         SBIS __keypad_port-2,__keypad_C1
        SBIS __keypad_port-2,__keypad_C1
; 0000 004E         RJMP Fin
        RJMP Fin
; 0000 004F         LDI R30,'7'
        LDI R30,'7'
; 0000 0050         SBI __keypad_port,__keypad_R2   ;R2=1
        SBI __keypad_port,__keypad_R2   ;R2=1
; 0000 0051         CBI __keypad_port,__keypad_R3   ;R3=0
        CBI __keypad_port,__keypad_R3   ;R3=0
; 0000 0052         NOP
        NOP
; 0000 0053         SBIS __keypad_port-2,__keypad_C1
        SBIS __keypad_port-2,__keypad_C1
; 0000 0054 

; 0000 0055         RJMP Fin
        RJMP Fin
; 0000 0056         LDI R30,'*'
        LDI R30,'*'
; 0000 0057         SBI __keypad_port,__keypad_R3   ;R3=1
        SBI __keypad_port,__keypad_R3   ;R3=1
; 0000 0058         CBI __keypad_port,__keypad_R4   ;R4=0
        CBI __keypad_port,__keypad_R4   ;R4=0
; 0000 0059         NOP
        NOP
; 0000 005A         SBIS __keypad_port-2,__keypad_C1
        SBIS __keypad_port-2,__keypad_C1
; 0000 005B         RJMP Fin
        RJMP Fin
; 0000 005C         CLR R30
        CLR R30
; 0000 005D         RJMP Fin
        RJMP Fin
; 0000 005E      BarridoC2:
     BarridoC2:
; 0000 005F         LDI R30,'2'
        LDI R30,'2'
; 0000 0060         SBI __keypad_port,__keypad_R2   ;R2=1
        SBI __keypad_port,__keypad_R2   ;R2=1
; 0000 0061         SBI __keypad_port,__keypad_R3   ;R3=1
        SBI __keypad_port,__keypad_R3   ;R3=1
; 0000 0062         SBI __keypad_port,__keypad_R4   ;R4=1
        SBI __keypad_port,__keypad_R4   ;R4=1
; 0000 0063         NOP
        NOP
; 0000 0064         SBIS __keypad_port-2,__keypad_C2
        SBIS __keypad_port-2,__keypad_C2
; 0000 0065         RJMP Fin
        RJMP Fin
; 0000 0066         LDI R30,'5'
        LDI R30,'5'
; 0000 0067         SBI __keypad_port,__keypad_R1   ;R1=1
        SBI __keypad_port,__keypad_R1   ;R1=1
; 0000 0068         CBI __keypad_port,__keypad_R2   ;R2=0
        CBI __keypad_port,__keypad_R2   ;R2=0
; 0000 0069         NOP
        NOP
; 0000 006A         SBIS __keypad_port-2,__keypad_C2
        SBIS __keypad_port-2,__keypad_C2
; 0000 006B         RJMP Fin
        RJMP Fin
; 0000 006C         LDI R30,'8'
        LDI R30,'8'
; 0000 006D         SBI __keypad_port,__keypad_R2   ;R2=1
        SBI __keypad_port,__keypad_R2   ;R2=1
; 0000 006E         CBI __keypad_port,__keypad_R3   ;R3=0
        CBI __keypad_port,__keypad_R3   ;R3=0
; 0000 006F         NOP
        NOP
; 0000 0070         SBIS __keypad_port-2,__keypad_C2
        SBIS __keypad_port-2,__keypad_C2
; 0000 0071         RJMP Fin
        RJMP Fin
; 0000 0072         LDI R30,'0'
        LDI R30,'0'
; 0000 0073         SBI __keypad_port,__keypad_R3   ;R3=1
        SBI __keypad_port,__keypad_R3   ;R3=1
; 0000 0074         CBI __keypad_port,__keypad_R4   ;R4=0
        CBI __keypad_port,__keypad_R4   ;R4=0
; 0000 0075         NOP
        NOP
; 0000 0076         SBIS __keypad_port-2,__keypad_C2
        SBIS __keypad_port-2,__keypad_C2
; 0000 0077         RJMP Fin
        RJMP Fin
; 0000 0078         CLR R30
        CLR R30
; 0000 0079 

; 0000 007A      BarridoC3:
     BarridoC3:
; 0000 007B         LDI R30,'3'
        LDI R30,'3'
; 0000 007C         SBI __keypad_port,__keypad_R2   ;R2=1
        SBI __keypad_port,__keypad_R2   ;R2=1
; 0000 007D         SBI __keypad_port,__keypad_R3   ;R3=1
        SBI __keypad_port,__keypad_R3   ;R3=1
; 0000 007E         SBI __keypad_port,__keypad_R4   ;R4=1
        SBI __keypad_port,__keypad_R4   ;R4=1
; 0000 007F         NOP
        NOP
; 0000 0080         SBIS __keypad_port-2,__keypad_C3
        SBIS __keypad_port-2,__keypad_C3
; 0000 0081         RJMP Fin
        RJMP Fin
; 0000 0082         LDI R30,'6'
        LDI R30,'6'
; 0000 0083         SBI __keypad_port,__keypad_R1   ;R1=1
        SBI __keypad_port,__keypad_R1   ;R1=1
; 0000 0084         CBI __keypad_port,__keypad_R2   ;R2=0
        CBI __keypad_port,__keypad_R2   ;R2=0
; 0000 0085         NOP
        NOP
; 0000 0086         SBIS __keypad_port-2,__keypad_C3
        SBIS __keypad_port-2,__keypad_C3
; 0000 0087         RJMP Fin
        RJMP Fin
; 0000 0088         LDI R30,'9'
        LDI R30,'9'
; 0000 0089         SBI __keypad_port,__keypad_R2   ;R2=1
        SBI __keypad_port,__keypad_R2   ;R2=1
; 0000 008A         CBI __keypad_port,__keypad_R3   ;R3=0
        CBI __keypad_port,__keypad_R3   ;R3=0
; 0000 008B         NOP
        NOP
; 0000 008C         SBIS __keypad_port-2,__keypad_C3
        SBIS __keypad_port-2,__keypad_C3
; 0000 008D         RJMP Fin
        RJMP Fin
; 0000 008E         LDI R30,'#'
        LDI R30,'#'
; 0000 008F         SBI __keypad_port,__keypad_R3   ;R3=1
        SBI __keypad_port,__keypad_R3   ;R3=1
; 0000 0090         CBI __keypad_port,__keypad_R4   ;R4=0
        CBI __keypad_port,__keypad_R4   ;R4=0
; 0000 0091         NOP
        NOP
; 0000 0092         SBIS __keypad_port-2,__keypad_C3
        SBIS __keypad_port-2,__keypad_C3
; 0000 0093         RJMP Fin
        RJMP Fin
; 0000 0094         CLR R30
        CLR R30
; 0000 0095      Fin:
     Fin:
; 0000 0096         CBI __keypad_port,__keypad_R1
        CBI __keypad_port,__keypad_R1
; 0000 0097         CBI __keypad_port,__keypad_R2
        CBI __keypad_port,__keypad_R2
; 0000 0098         CBI __keypad_port,__keypad_R3
        CBI __keypad_port,__keypad_R3
; 0000 0099         CBI __keypad_port,__keypad_R4
        CBI __keypad_port,__keypad_R4
; 0000 009A 

; 0000 009B     #endasm
; 0000 009C }
	RET
; .FEND
;#pragma warn+
;
;typedef unsigned short uint8_t;
;
;unsigned int distancia;
;unsigned int estado;
;char tecla;
;unsigned int i = 0;
;unsigned int estatus = 1;

	.DSEG
;// 1 - Alarma Activada
;// 2 - Alarma Desactivada
;// 3 - Cambiar clave
;
;char read_key[4];
;char write_key[4];
;uint8_t setting;
;
;void trigger_s()
; 0000 00AF {

	.CSEG
_trigger_s:
; .FSTART _trigger_s
; 0000 00B0     PORTB.0 = 1;  //Enviar señal
	SBI  0x5,0
; 0000 00B1     delay_us(10); //Despues del delay, trigger envia pulsos de 40KHz y echo comienza a medir
	__DELAY_USB 27
; 0000 00B2     PORTB.0 = 0;  //Apagar señal
	CBI  0x5,0
; 0000 00B3 }
	RET
; .FEND
;
;void echo_s()
; 0000 00B6 {
_echo_s:
; .FSTART _echo_s
; 0000 00B7     distancia = 0;
	LDI  R30,LOW(0)
	STS  _distancia,R30
	STS  _distancia+1,R30
; 0000 00B8     while(PINB.1 == 0); //Esperar activacion de echo
_0x27:
	SBIS 0x3,1
	RJMP _0x27
; 0000 00B9 
; 0000 00BA     do
_0x2B:
; 0000 00BB       {
; 0000 00BC         delay_us(54);
	__DELAY_USB 144
; 0000 00BD         #asm("NOP")
	NOP
; 0000 00BE         distancia++; //Sumar un cm de distancia por cada 54 us de echo
	LDI  R26,LOW(_distancia)
	LDI  R27,HIGH(_distancia)
	RCALL SUBOPT_0x0
; 0000 00BF       }
; 0000 00C0     while ((PINB.1 == 1) && (distancia<400));
	SBIS 0x3,1
	RJMP _0x2D
	RCALL SUBOPT_0x1
	CPI  R26,LOW(0x190)
	LDI  R30,HIGH(0x190)
	CPC  R27,R30
	BRLO _0x2E
_0x2D:
	RJMP _0x2C
_0x2E:
	RJMP _0x2B
_0x2C:
; 0000 00C1 }
	RET
; .FEND
;
;void reiniciaClave()
; 0000 00C4 {
_reiniciaClave:
; .FSTART _reiniciaClave
; 0000 00C5    unsigned char i;
; 0000 00C6    for (i=0;i<4;i++)
	ST   -Y,R16
;	i -> R16
	LDI  R16,LOW(0)
_0x30:
	CPI  R16,4
	BRSH _0x31
; 0000 00C7    {
; 0000 00C8       read_key[i]='0';
	RCALL SUBOPT_0x2
	LDI  R26,LOW(48)
	STD  Z+0,R26
; 0000 00C9    }
	SUBI R16,-1
	RJMP _0x30
_0x31:
; 0000 00CA }
_0x2080004:
	LD   R16,Y+
	RET
; .FEND
;
;int comparaClave(){
; 0000 00CC int comparaClave(){
_comparaClave:
; .FSTART _comparaClave
; 0000 00CD    unsigned char i;
; 0000 00CE    unsigned int resultado = 1;
; 0000 00CF    for (i=0;i<4;i++)
	RCALL __SAVELOCR3
;	i -> R16
;	resultado -> R17,R18
	__GETWRN 17,18,1
	LDI  R16,LOW(0)
_0x33:
	CPI  R16,4
	BRSH _0x34
; 0000 00D0    {
; 0000 00D1      if(read_key[i] != write_key[i])
	RCALL SUBOPT_0x2
	LD   R26,Z
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_write_key)
	SBCI R31,HIGH(-_write_key)
	LD   R30,Z
	CP   R30,R26
	BREQ _0x35
; 0000 00D2         resultado = 0;
	__GETWRN 17,18,0
; 0000 00D3    }
_0x35:
	SUBI R16,-1
	RJMP _0x33
_0x34:
; 0000 00D4    return resultado;
	__GETW1R 17,18
_0x2080003:
	RCALL __LOADLOCR3
_0x2080002:
	ADIW R28,3
	RET
; 0000 00D5 }
; .FEND
;
;void esperaTeclaNoImprime()
; 0000 00D8 {
_esperaTeclaNoImprime:
; .FSTART _esperaTeclaNoImprime
; 0000 00D9     //Espera a presionar tecla
; 0000 00DA     do{
_0x37:
; 0000 00DB         tecla=LeeTeclado();
	RCALL _LeeTeclado
	STS  _tecla,R30
; 0000 00DC     }while(tecla==0);
	CPI  R30,0
	BREQ _0x37
; 0000 00DD     write_key[i] = tecla;
	RCALL SUBOPT_0x3
; 0000 00DE     //Espera a soltar tecla
; 0000 00DF     do{
_0x3A:
; 0000 00E0         tecla=LeeTeclado();
	RCALL _LeeTeclado
	STS  _tecla,R30
; 0000 00E1     }while(tecla!=0);
	CPI  R30,0
	BRNE _0x3A
; 0000 00E2 }
	RET
; .FEND
;
;void esperaTeclaImprime()
; 0000 00E5 {
_esperaTeclaImprime:
; .FSTART _esperaTeclaImprime
; 0000 00E6     //Espera a presionar tecla
; 0000 00E7     do{
_0x3D:
; 0000 00E8         tecla=LeeTeclado();
	RCALL _LeeTeclado
	STS  _tecla,R30
; 0000 00E9 
; 0000 00EA     }while(tecla==0);
	CPI  R30,0
	BREQ _0x3D
; 0000 00EB     write_key[i] = tecla;
	RCALL SUBOPT_0x3
; 0000 00EC     CharLCD(tecla);
	LDS  R26,_tecla
	RCALL _CharLCD
; 0000 00ED     //Espera a soltar tecla
; 0000 00EE     do{
_0x40:
; 0000 00EF         tecla=LeeTeclado();
	RCALL _LeeTeclado
	STS  _tecla,R30
; 0000 00F0     }while(tecla!=0);
	CPI  R30,0
	BRNE _0x40
; 0000 00F1 }
	RET
; .FEND
;
;
;void esperaTeclaImprimeConSensor()
; 0000 00F5 {
_esperaTeclaImprimeConSensor:
; .FSTART _esperaTeclaImprimeConSensor
; 0000 00F6     //Espera a presionar tecla
; 0000 00F7     do{
_0x43:
; 0000 00F8         tecla=LeeTeclado();
	RCALL _LeeTeclado
	STS  _tecla,R30
; 0000 00F9         //Activar sensor
; 0000 00FA         trigger_s();
	RCALL _trigger_s
; 0000 00FB         echo_s();
	RCALL _echo_s
; 0000 00FC         //Si detecta algo a 20 cm o menos, activa sonido y led
; 0000 00FD         if(distancia <= 20 || estado == 1)
	RCALL SUBOPT_0x1
	SBIW R26,21
	BRLO _0x46
	LDS  R26,_estado
	LDS  R27,_estado+1
	SBIW R26,1
	BRNE _0x45
_0x46:
; 0000 00FE         {
; 0000 00FF             PORTB.2 = 1;
	SBI  0x5,2
; 0000 0100             PORTD.7 = 1;
	SBI  0xB,7
; 0000 0101             estado = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _estado,R30
	STS  _estado+1,R31
; 0000 0102         }
; 0000 0103 
; 0000 0104     }while(tecla==0);
_0x45:
	LDS  R30,_tecla
	CPI  R30,0
	BREQ _0x43
; 0000 0105     write_key[i] = tecla;
	RCALL SUBOPT_0x3
; 0000 0106     CharLCD(tecla);
	LDS  R26,_tecla
	RCALL _CharLCD
; 0000 0107     //Espera a soltar tecla
; 0000 0108     do{
_0x4D:
; 0000 0109         tecla=LeeTeclado();
	RCALL _LeeTeclado
	STS  _tecla,R30
; 0000 010A     }while(tecla!=0);
	CPI  R30,0
	BRNE _0x4D
; 0000 010B }
	RET
; .FEND
;
;void main(void)
; 0000 010E {
_main:
; .FSTART _main
; 0000 010F     // Micro a 8MHz
; 0000 0110     CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0111     CLKPR=0;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0112 
; 0000 0113     SetupLCD();
	RCALL _SetupLCD
; 0000 0114     SetupKeypad();
	RCALL _SetupKeypad
; 0000 0115 
; 0000 0116     PORTB.1 = 1; //PC1 entrada pull-up para echo
	SBI  0x5,1
; 0000 0117     DDRB.0 = 1;  //PC0 salida para trigger
	SBI  0x4,0
; 0000 0118     DDRD.7 = 1;  //PD7 salida para bocina
	SBI  0xA,7
; 0000 0119     DDRB.2 = 1;  //PB2 salida para led
	SBI  0x4,2
; 0000 011A 
; 0000 011B     // Lectura inicial eeprom y configuracion si aplica
; 0000 011C     eeprom_read_block((const void*)read_key , (eeprom void*)45, 4);
	RCALL SUBOPT_0x4
; 0000 011D     setting = eeprom_read_byte((uint8_t*)45);
	LDI  R26,LOW(45)
	LDI  R27,HIGH(45)
	RCALL __EEPROMRDB
	LDI  R31,0
	STS  _setting,R30
	STS  _setting+1,R31
; 0000 011E     if(setting == 0xff) {
	LDS  R26,_setting
	LDS  R27,_setting+1
	CPI  R26,LOW(0xFF)
	LDI  R30,HIGH(0xFF)
	CPC  R27,R30
	BRNE _0x57
; 0000 011F         reiniciaClave();
	RCALL _reiniciaClave
; 0000 0120     }
; 0000 0121 
; 0000 0122     while (1)
_0x57:
_0x58:
; 0000 0123         {
; 0000 0124 
; 0000 0125             switch(estatus)
	LDS  R30,_estatus
	LDS  R31,_estatus+1
; 0000 0126             {
; 0000 0127                 // Estatus inicial, checar sensor
; 0000 0128                 case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x5E
; 0000 0129                     MoveCursor(1,0);
	RCALL SUBOPT_0x5
; 0000 012A                     StringLCD("ALARMA ACTIVA");
	__POINTW2FN _0x0,0
	RCALL SUBOPT_0x6
; 0000 012B                     MoveCursor(0,1);
; 0000 012C                     StringLCD("CLAVE: ");
; 0000 012D                     MoveCursor(7+i,1);
; 0000 012E 
; 0000 012F                     esperaTeclaImprimeConSensor();
	RCALL _esperaTeclaImprimeConSensor
; 0000 0130                     i++;
	LDI  R26,LOW(_i)
	LDI  R27,HIGH(_i)
	RCALL SUBOPT_0x0
; 0000 0131 
; 0000 0132                     //Si ya ingreso clave de 4 digitos
; 0000 0133                     if(i == 4){
	RCALL SUBOPT_0x7
	BRNE _0x5F
; 0000 0134                         if(comparaClave() == 1){
	RCALL _comparaClave
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x60
; 0000 0135                             estado = 0;
	RCALL SUBOPT_0x8
; 0000 0136                             estatus = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x9
; 0000 0137                         }
; 0000 0138                         EraseLCD();
_0x60:
	RCALL _EraseLCD
; 0000 0139                         i = 0;
	RCALL SUBOPT_0xA
; 0000 013A                     }
; 0000 013B 
; 0000 013C                     break;
_0x5F:
	RJMP _0x5D
; 0000 013D 
; 0000 013E                 //Estatus de alarma desactivada, se puede volver a activar la alarma
; 0000 013F                 // o se puede cambiar la clave
; 0000 0140                 case 2:
_0x5E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x61
; 0000 0141 
; 0000 0142                     //Desactivar alarma porque ingreso contraseña correcta
; 0000 0143                     PORTB.2 = 0;
	CBI  0x5,2
; 0000 0144                     PORTD.7 = 0;
	CBI  0xB,7
; 0000 0145                     estado = 0;
	RCALL SUBOPT_0x8
; 0000 0146 
; 0000 0147                     MoveCursor(5,0);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _MoveCursor
; 0000 0148                     StringLCD("ALARMA");
	__POINTW2FN _0x0,22
	RCALL _StringLCD
; 0000 0149                     MoveCursor(2,1);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _MoveCursor
; 0000 014A                     StringLCD("DESACTIVADA");
	__POINTW2FN _0x0,29
	RCALL _StringLCD
; 0000 014B 
; 0000 014C                     esperaTeclaNoImprime();
	RCALL _esperaTeclaNoImprime
; 0000 014D 
; 0000 014E                     if(write_key[i] == '*'){
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x2A)
	BRNE _0x66
; 0000 014F                         // Estatus para activar alarma
; 0000 0150                         i = 0;
	RCALL SUBOPT_0xA
; 0000 0151                         estatus = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x9
; 0000 0152                         EraseLCD();
	RCALL _EraseLCD
; 0000 0153                         //Delay para que el usuario corra
; 0000 0154                         MoveCursor(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _MoveCursor
; 0000 0155                         StringLCD("ALARMA ACTIVADA");
	__POINTW2FN _0x0,41
	RCALL _StringLCD
; 0000 0156                         delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _delay_ms
; 0000 0157                         EraseLCD();
	RJMP _0x6D
; 0000 0158 
; 0000 0159                     }else if(write_key[i] == '#'){
_0x66:
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x23)
	BRNE _0x68
; 0000 015A                         // Estatus para cambiar clave
; 0000 015B                         i = 0;
	RCALL SUBOPT_0xA
; 0000 015C                         estatus = 3;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x9
; 0000 015D                         EraseLCD();
_0x6D:
	RCALL _EraseLCD
; 0000 015E                     }
; 0000 015F                     break;
_0x68:
	RJMP _0x5D
; 0000 0160 
; 0000 0161                 // Estatus para cambiar clave
; 0000 0162                 case 3:
_0x61:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x5D
; 0000 0163                     MoveCursor(1,0);
	RCALL SUBOPT_0x5
; 0000 0164                     StringLCD("CAMBIAR CLAVE");
	__POINTW2FN _0x0,57
	RCALL SUBOPT_0x6
; 0000 0165                     MoveCursor(0,1);
; 0000 0166                     StringLCD("CLAVE: ");
; 0000 0167                     MoveCursor(7+i,1);
; 0000 0168 
; 0000 0169                     esperaTeclaImprime();
	RCALL _esperaTeclaImprime
; 0000 016A 
; 0000 016B                     i++;
	LDI  R26,LOW(_i)
	LDI  R27,HIGH(_i)
	RCALL SUBOPT_0x0
; 0000 016C 
; 0000 016D                     // Si ya ingreso clave de 4 digitos
; 0000 016E                     if(i == 4){
	RCALL SUBOPT_0x7
	BRNE _0x6A
; 0000 016F                         // Escribir y leer valor de eeprom y cambiar a estatus
; 0000 0170                         // de alarma activa
; 0000 0171                         eeprom_write_block(write_key,(eeprom void*)45,sizeof(write_key));
	LDI  R30,LOW(_write_key)
	LDI  R31,HIGH(_write_key)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(45)
	LDI  R31,HIGH(45)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(4)
	LDI  R27,0
	RCALL _eeprom_write_block
; 0000 0172                         eeprom_read_block(read_key,(eeprom void*)45,sizeof(read_key));
	RCALL SUBOPT_0x4
; 0000 0173                         estatus = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x9
; 0000 0174                         i = 0;
	RCALL SUBOPT_0xA
; 0000 0175                         EraseLCD();
	RCALL _EraseLCD
; 0000 0176                         //Delay para que el usuario corra
; 0000 0177                         delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _delay_ms
; 0000 0178                     }
; 0000 0179                     break;
_0x6A:
; 0000 017A             }
_0x5D:
; 0000 017B 
; 0000 017C 
; 0000 017D 
; 0000 017E 
; 0000 017F 
; 0000 0180 
; 0000 0181         }
	RJMP _0x58
; 0000 0182 }
_0x6B:
	RJMP _0x6B
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG
_eeprom_read_block:
; .FSTART _eeprom_read_block
	RCALL SUBOPT_0xC
	__GETWRS 16,17,10
	__GETWRS 18,19,8
_0x2020003:
	RCALL SUBOPT_0xD
	BREQ _0x2020005
	PUSH R17
	PUSH R16
	RCALL SUBOPT_0xE
	RCALL __EEPROMRDB
	POP  R26
	POP  R27
	ST   X,R30
	RJMP _0x2020003
_0x2020005:
	RJMP _0x2080001
; .FEND
_eeprom_write_block:
; .FSTART _eeprom_write_block
	RCALL SUBOPT_0xC
	__GETWRS 16,17,8
	__GETWRS 18,19,10
_0x2020006:
	RCALL SUBOPT_0xD
	BREQ _0x2020008
	PUSH R17
	PUSH R16
	RCALL SUBOPT_0xE
	LD   R30,X
	POP  R26
	POP  R27
	RCALL __EEPROMWRB
	RJMP _0x2020006
_0x2020008:
_0x2080001:
	RCALL __LOADLOCR6
	ADIW R28,12
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_cursor:
	.BYTE 0x1
_distancia:
	.BYTE 0x2
_estado:
	.BYTE 0x2
_tecla:
	.BYTE 0x1
_i:
	.BYTE 0x2
_estatus:
	.BYTE 0x2
_read_key:
	.BYTE 0x4
_write_key:
	.BYTE 0x4
_setting:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x0:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDS  R26,_distancia
	LDS  R27,_distancia+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_read_key)
	SBCI R31,HIGH(-_read_key)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x3:
	LDS  R30,_i
	LDS  R31,_i+1
	SUBI R30,LOW(-_write_key)
	SBCI R31,HIGH(-_write_key)
	LDS  R26,_tecla
	STD  Z+0,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(_read_key)
	LDI  R31,HIGH(_read_key)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(45)
	LDI  R31,HIGH(45)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(4)
	LDI  R27,0
	RJMP _eeprom_read_block

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _MoveCursor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x6:
	RCALL _StringLCD
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _MoveCursor
	__POINTW2FN _0x0,14
	RCALL _StringLCD
	LDS  R30,_i
	SUBI R30,-LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _MoveCursor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7:
	LDS  R26,_i
	LDS  R27,_i+1
	SBIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(0)
	STS  _estado,R30
	STS  _estado+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9:
	STS  _estatus,R30
	STS  _estatus+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(0)
	STS  _i,R30
	STS  _i+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xB:
	LDS  R30,_i
	LDS  R31,_i+1
	SUBI R30,LOW(-_write_key)
	SBCI R31,HIGH(-_write_key)
	LD   R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	ST   -Y,R27
	ST   -Y,R26
	RCALL __SAVELOCR6
	__GETWRS 20,21,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	__ADDWRN 16,17,1
	MOVW R26,R18
	__ADDWRN 18,19,1
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	PUSH R26
	PUSH R27
	MOVW R26,R22
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	POP  R27
	POP  R26
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
