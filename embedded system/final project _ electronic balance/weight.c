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
#define GapValue 430

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
	/*Get_Maopi();
	Get_Maopi();
	Delay_ms(2000);		 //延时
	Get_Maopi();
	Get_Maopi();				//多次测量有利于HX711稳定
  LCD1602_write_com(0x01);    //清屏
    //读取EEPROM中保存的报警值
    maxValueTable[0] = byte_read(0x2000);
    maxValueTable[1] = byte_read(0x2001);
    maxValueTable[2] = byte_read(0x2002);
    maxValueTable[3] = byte_read(0x2003);
    Max_Value = maxValueTable[0]*1000+maxValueTable[1]*100+maxValueTable[2]*10+maxValueTable[3];    //计算超限报警界限值
	
	while(1)
	{*/
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

		/*KEY_NUM = Scan_Key();
        if(KEY_NUM == 1)        //press 1 to switch statement
        {
            state++;
            if(state == 5)
            {
                state = 0;
                SectorErase(0x2000);
                byte_write(0x2000,maxValueTable[0]);				//store data of EEPROM
                byte_write(0x2001,maxValueTable[1]);
                byte_write(0x2002,maxValueTable[2]);				//store data of EEPROM
                byte_write(0x2003,maxValueTable[3]);
                Max_Value = maxValueTable[0]*1000+maxValueTable[1]*100+maxValueTable[2]*10+maxValueTable[3];    //计算超限报警界限值
            }
        }
        if(KEY_NUM == 2)        //按键加
        {
            if(state != 0)
            {
                maxValueTable[state-1]++;
                if(maxValueTable[state-1] >= 10)
                {
                    maxValueTable[state-1] = 0;
                }
            }
            
        }
        if(KEY_NUM == 3)        //按键减
        {
            if(state != 0)
            {
                maxValueTable[state-1]--;
                if(maxValueTable[state-1] <= -1)
                {
                    maxValueTable[state-1] = 9;
                }
            }
        }
		if(KEY_NUM == 4)
		{
			Get_Maopi();			//去皮	
		}
        
        
        if(state != 0)
        {
            Blink_Speed ++;
            if(Blink_Speed == Blink_Speed_Max)
            {
                Blink_Speed = 0;
            }
        }
        switch(state)
        {
            case 0:
                LCD1602_write_com(0x80+0x40);
                LCD1602_write_word("MAX=");
                LCD1602_write_data(maxValueTable[0]+0x30);
                LCD1602_write_data('.');
                LCD1602_write_data(maxValueTable[1]+0x30);
                LCD1602_write_data(maxValueTable[2]+0x30);
                LCD1602_write_data(maxValueTable[3]+0x30);
                LCD1602_write_word("Kg");
                break;
            case 1:
                LCD1602_write_com(0x80+0x40);
                LCD1602_write_word("MAX=");
                if(Blink_Speed < Blink_Speed_Max/2)
                {
                    LCD1602_write_data(maxValueTable[0]+0x30);
                }
                else
                {
                    LCD1602_write_data(' ');
                }
                LCD1602_write_data('.');
                LCD1602_write_data(maxValueTable[1]+0x30);
                LCD1602_write_data(maxValueTable[2]+0x30);
                LCD1602_write_data(maxValueTable[3]+0x30);
                LCD1602_write_word("Kg");
                break;
            case 2:
                LCD1602_write_com(0x80+0x40);
                LCD1602_write_word("MAX=");
                LCD1602_write_data(maxValueTable[0]+0x30);
                LCD1602_write_data('.');
                if(Blink_Speed < Blink_Speed_Max/2)
                {
                    LCD1602_write_data(maxValueTable[1]+0x30);
                }
                else
                {
                    LCD1602_write_data(' ');
                }
                LCD1602_write_data(maxValueTable[2]+0x30);
                LCD1602_write_data(maxValueTable[3]+0x30);
                LCD1602_write_word("Kg");
                break;
            case 3:
                LCD1602_write_com(0x80+0x40);
                LCD1602_write_word("MAX=");
                LCD1602_write_data(maxValueTable[0]+0x30);
                LCD1602_write_data('.');
                LCD1602_write_data(maxValueTable[1]+0x30);
                if(Blink_Speed < Blink_Speed_Max/2)
                {
                    LCD1602_write_data(maxValueTable[2]+0x30);
                }
                else
                {
                    LCD1602_write_data(' ');
                }                
                LCD1602_write_data(maxValueTable[3]+0x30);
                LCD1602_write_word("Kg");
                break;
            case 4:
                LCD1602_write_com(0x80+0x40);
                LCD1602_write_word("MAX=");
                LCD1602_write_data(maxValueTable[0]+0x30);
                LCD1602_write_data('.');
                LCD1602_write_data(maxValueTable[1]+0x30);
                LCD1602_write_data(maxValueTable[2]+0x30);
                if(Blink_Speed < Blink_Speed_Max/2)
                {
                    LCD1602_write_data(maxValueTable[3]+0x30);
                }
                else
                {
                    LCD1602_write_data(' ');
                }                 
                LCD1602_write_word("Kg");
                break;
            default:
                break;
            
        }*/
        
        //超限报警
        if(Weight_Shiwu >= Max_Value || Weight_Shiwu >= AlarmValue)	        //超过设置最大值或者传感器本身量程最大值报警	
		{
			Buzzer = 0;	
		}
		else
		{
			Buzzer = 1;
		}
	 // }
	}
//****************************************************
//称重
//****************************************************
void Get_Weight()
{
	Weight_Shiwu = HX711_Read();
	Weight_Shiwu = Weight_Shiwu - Weight_Maopi;		//获取净重
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
//获取毛皮重量
//****************************************************
void Get_Maopi()
{
	Weight_Maopi = HX711_Read();	
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
//蜂鸣器程序
//****************************************************
void Buzzer_Di()
{
	Buzzer = 0;
	Delay_ms(10);
	Buzzer = 1;
	Delay_ms(10);
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
