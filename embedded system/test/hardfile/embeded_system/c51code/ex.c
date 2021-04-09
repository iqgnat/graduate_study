#include<reg51.h>           //  包含51单片机寄存器定义的头文件
 void delay(void)        //延时函数，延时约0.6毫秒
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