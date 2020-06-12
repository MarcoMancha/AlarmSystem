/*
 * LCDDemoTeensy.c
 *
 * Created: 21/02/2017 02:13:41 p. m.
 * Author: adomingu
 */
#asm
    .equ __lcd_port=0x11
    .equ __lcd_EN=4
    .equ __lcd_RS=5
    .equ __lcd_D4=0
    .equ __lcd_D5=1
    .equ __lcd_D6=2
    .equ __lcd_D7=3
#endasm

#include <io.h>
#include <delay.h>
#include <display.h>

void main(void)
{
    SetupLCD(); 
    MoveCursor(6,0);
    StringLCD("HOLA");
    MoveCursor(5,1);
    StringLCD("MUNDO!"); 
        
    while (1)
    {
    // Please write your application code here

    }
}
