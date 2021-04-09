#include "EEPROM.H"
#include "LCD1602.h"
#include "HX711.h"
//#include "Delay_ms.h"
#include "WEIGHT.H"

//定义变量
unsigned char KEY_NUM = 0;   //用来存放按键按下的键值
unsigned long HX711_Buffer = 0;  //用来存放HX711读取出来的数据
unsigned long Weight_Maopi = 0; //用来存放毛皮数据
long Weight_Shiwu = 0;          //用来存放实物重量
long Max_Value = 0;             //用来存放设置最大值
char maxValueTable[4] = {1,0,0,0};
unsigned char state = 0;    //用来存放设置状态
unsigned char Blink_Speed = 0;
#define Blink_Speed_Max 6          //该值可以改变设置指针闪烁频率

//校准参数
//当发现测试出来的重量偏大时，增加该数值。
//如果测试出来的重量偏小时，减小改数值。
#define GapValue 100

//传感器最大测量值，单位是g
#define AlarmValue 5000			

//****************************************************
//主函数
//****************************************************

void weight_initial(void)
{
	Init_LCD1602();						//初始化LCD1602
	LCD1602_write_com(0x80);			//设置LCD1602指针
	LCD1602_write_word("Welcome to use!");}
	
void weight_update(void )
{

        Get_Weight();		
	
		//display current weight
		LCD1602_write_com(0x80);
        LCD1602_write_word("Weight=");
		LCD1602_write_data(Weight_Shiwu%10000/1000 + 0x30);
		LCD1602_write_data('.');
		LCD1602_write_data(Weight_Shiwu%1000/100 + 0x30);
 		LCD1602_write_data(Weight_Shiwu%100/10 + 0x30);
		LCD1602_write_data(Weight_Shiwu%10 + 0x30);		
		LCD1602_write_word("Kg");

//        if(Weight_Shiwu >= Max_Value || Weight_Shiwu >= AlarmValue)	        //超过设置最大值或者传感器本身量程最大值报警	
//		{
//			Buzzer = 0;	
//		}
//		else
//		{
//			Buzzer = 1;
//		}
	 // }
	}
//****************************************************
//称重
//****************************************************
void Get_Weight()
{
	Weight_Shiwu = HX711_Read();
	if(Weight_Shiwu >= 0)			
	{	
		Weight_Shiwu = (unsigned long)((float)Weight_Shiwu/GapValue); 	//计算实物的实际重量
	}
	else
	{
		Weight_Shiwu = 0;
	}
}



//****************************************************
//MS延时函数(12M晶振下测试)
//****************************************************
void Delay_ms(unsigned int n)
{
	unsigned int  i,j;
	for(i=0;i<n;i++)
		for(j=0;j<123;j++);
}



//****************************************************
//按键扫描程序
//****************************************************
unsigned char Scan_Key()
{	
    if( KEY1 == 0 )						//按键扫描
	{
		Delay_ms(10);					//延时去抖
		if( KEY1 == 0 )
		{
			Buzzer_Di();
			while(KEY1 == 0);			//等待松手
			return 1;
		}
	}
    if( KEY2 == 0 )						//按键扫描
	{
		Delay_ms(10);					//延时去抖
		if( KEY2 == 0 )
		{
			Buzzer_Di();
			while(KEY2 == 0);			//等待松手
			return 2;
		}
	}
    if( KEY3 == 0 )						//按键扫描
	{
		Delay_ms(10);					//延时去抖
		if( KEY3 == 0 )
		{
			Buzzer_Di();
			while(KEY3 == 0);			//等待松手
			return 3;
		}
	}
	if( KEY4 == 0 )						//按键扫描
	{
		Delay_ms(10);					//延时去抖
		if( KEY4 == 0 )
		{
			Buzzer_Di();
			while(KEY4 == 0);			//等待松手
			return 4;
		}
	}
    return 0;
}
