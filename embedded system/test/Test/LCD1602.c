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
	LCD1602_write_com(0x38);			//��ʾģʽ�趨
	LCD1602_write_com(0x0c);			//������ʾ������������á������˸����
	LCD1602_write_com(0x06);			//дһ���ַ���ָ���һ
	LCD1602_write_com(0x01);			//����ָ��
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
//дָ��
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
//д����
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
//����д�ַ�
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
//	LCD1602_RW = 0;						//����Ϊд״̬
//	LCD1602_write_com(0x38);			//��ʾģʽ�趨
//	LCD1602_write_com(0x0c);			//������ʾ������������á������˸����
//	LCD1602_write_com(0x06);			//дһ���ַ���ָ���һ
//	LCD1602_write_com(0x01);			//����ָ��
//}
