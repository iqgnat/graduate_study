#include<reg51.h>           //  ����51��Ƭ���Ĵ��������ͷ�ļ�
 void delay(void)        //��ʱ��������ʱԼ0.6����
{
   unsigned char i;
	for(i=0;i<2000;i++)  
           ;
 }
void main(void)
{
   while(1)    //
   {
			P0=1;
			delay();
			P0=0;
			delay();
   } 
}