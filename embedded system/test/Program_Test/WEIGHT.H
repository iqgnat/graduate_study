
#ifndef __WEIGHT_H__
#define __WEIGHT_H__

#include"at89x52.h"

sbit Buzzer = P2^4;

//按键 IO设置
sbit KEY1 = P1^4;
sbit KEY2 = P1^5;
sbit KEY3 = P1^6;
sbit KEY4 = P1^7;

//函数或者变量声明
//extern void Delay_ms(unsigned int n);
//extern unsigned char Scan_Key();
//extern void Buzzer_Di();
//extern void Get_Maopi();
extern void Get_Weight();

//extern unsigned char KEY_NUM;
extern void weight_initial(void);
extern void weight_update(void );

//extern void Delay_ms(unsigned int n);
#endif