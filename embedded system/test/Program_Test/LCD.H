#ifndef _LCD_H_
#define _LCD_H_

//Different Project, Different Setting
sbit ADDR0=P2^5;
sbit ADDR1=P2^6;
sbit ENLCD1=P2^7;
sbit DB0=P0^0;
sbit DB1=P0^1;
sbit DB2=P0^2;
sbit DB3=P0^3;
sbit DB4=P0^4;
sbit DB5=P0^5;
sbit DB6=P0^6;
sbit DB7=P0^7;

void waiting()
{
	unsigned char i, j;
	for(i = 0; i < 50; i++)
  		for(j = 0; j < 110; j++);
}

void write_cmd(unsigned char cmd)
{
	waiting();
	ENLCD1=0;
	ADDR0=0;
	ADDR1=0;
	P0=cmd;
	ENLCD1=1;
	ENLCD1=0;
}

void write_data(unsigned char dat)
{
	waiting();
	ENLCD1=0;
	ADDR0=1;
	ADDR1=0;
	P0=dat;
	ENLCD1=1;
	ENLCD1=0;
}

//Main Display Function
/*
Display one string in first line or second line.
Input:
	addr: 0x00 for first line; 0x40 for second line.
	p: char array.
*/
void write_string(unsigned char addr,unsigned char *p)
{
	addr=addr|0x80; // first line: 0x00,  second line: 0x40
	write_cmd(addr);
	while(*p!='\0')
	{
		write_data(*p++);
	}
}

//LCD initialization
void LCD_init()
{
	write_cmd(0x38);
	write_cmd(0x0C);
	write_cmd(0x06);
	write_cmd(0x01);
}

#endif