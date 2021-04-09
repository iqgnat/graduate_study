#include "LCD1602.h"

//****************************************************
//MS��ʱ����(12M�����²���)
//****************************************************
void LCD1602_delay_ms(unsigned int n)
{
	unsigned int  i,j;
	for(i=0;i<n;i++)
		for(j=0;j<123;j++);
}

//****************************************************
//дָ��
//****************************************************
void LCD1602_write_com(unsigned char com)
{
	LCD1602_RS = 0;
	LCD1602_delay_ms(1);
	LCD1602_EN = 1;
	LCD1602_PORT = com;
	LCD1602_delay_ms(1);
	LCD1602_EN = 0;
}
//****************************************************
//д����
//****************************************************
void LCD1602_write_data(unsigned char dat)
{
	LCD1602_RS = 1;
	LCD1602_delay_ms(1);	
	LCD1602_PORT = dat;
	LCD1602_EN = 1;
	LCD1602_delay_ms(1);
	LCD1602_EN = 0;
}
//****************************************************
//����д�ַ�
//****************************************************
void LCD1602_write_word(unsigned char *s)
{
	while(*s>0)
	{
		LCD1602_write_data(*s);
		s++;
	}
}

void Init_LCD1602()
{
	LCD1602_EN = 0;
	LCD1602_RW = 0;						//����Ϊд״̬
	LCD1602_write_com(0x38);			//��ʾģʽ�趨
	LCD1602_write_com(0x0c);			//������ʾ������������á������˸����
	LCD1602_write_com(0x06);			//дһ���ַ���ָ���һ
	LCD1602_write_com(0x01);			//����ָ��
}

