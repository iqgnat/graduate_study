#include "LCD1602.h"
void LCD1602_delay_ms()
{
	unsigned int  i,j;
	for(i=0;i<50;i++)
		for(j=0;j<11000;j++);
	//	for(j=0;j<123;j++);
}


void LCD1602_write_com(unsigned char com)
{
  LCD1602_delay_ms();	
	LCD1602_EN = 0;
	LCD1602_RS = 0;
  LCD1602_RW = 0;
	LCD1602_PORT = com;
	LCD1602_EN = 1;
	LCD1602_EN = 0;
}

void LCD1602_write_data(unsigned char dat)
{
	LCD1602_delay_ms();	
	LCD1602_EN = 0;
	LCD1602_RS = 1;
	LCD1602_RW = 0;
	LCD1602_PORT = dat;
	LCD1602_EN = 1;
	LCD1602_EN = 0;
}

void LCD1602_write_word(unsigned char *s)
{
//	addr=addr|0x80; 
//	LCD1602_write_com(addr);
	while(*s!='\0')
	{
		LCD1602_write_data(*s++);
	}
}


void Init_LCD1602()
{
	LCD1602_write_com(0x38);			//显示模式设定
	LCD1602_write_com(0x0c);			//开关显示、光标有无设置、光标闪烁设置
	LCD1602_write_com(0x06);			//写一个字符后指针加一
	LCD1602_write_com(0x01);			//清屏指令
}
//----------------------------------------------------------------------
//#include "LCD1602.h"

//void LCD1602_delay_ms()
//{
//	unsigned int  i,j;
//	for(i=0;i<50;i++)
//		for(j=0;j<123;j++);
//	//	for(j=0;j<123;j++);
//}

//****************************************************
//写指令
//****************************************************
//void LCD1602_write_com(unsigned char com)
//{
//	LCD1602_RS = 0;
//	LCD1602_delay_ms(1);
//	LCD1602_EN = 1;
//	LCD1602_PORT = com;
//	LCD1602_delay_ms(1);
//	LCD1602_EN = 0;
//}
//****************************************************
//写数据
//****************************************************
//void LCD1602_write_data(unsigned char dat)
//{
//	LCD1602_RS = 1;
//	LCD1602_delay_ms(1);	
//	LCD1602_PORT = dat;
//	LCD1602_EN = 1;
//	LCD1602_delay_ms(1);
//	LCD1602_EN = 0;
//}
//****************************************************
//连续写字符
//****************************************************
//void LCD1602_write_word(unsigned char *s)
//{
//	while(*s>0)
//	{
//		LCD1602_write_data(*s);
//		s++;
//	}
//}

//void Init_LCD1602()
//{
//	LCD1602_EN = 0;
//	LCD1602_RW = 0;						//设置为写状态
//	LCD1602_write_com(0x38);			//显示模式设定
//	LCD1602_write_com(0x0c);			//开关显示、光标有无设置、光标闪烁设置
//	LCD1602_write_com(0x06);			//写一个字符后指针加一
//	LCD1602_write_com(0x01);			//清屏指令
//}
