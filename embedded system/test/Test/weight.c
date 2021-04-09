#include "EEPROM.H"
#include "LCD1602.h"
#include "HX711.h"
//#include "Delay_ms.h"
#include "WEIGHT.H"

//�������
unsigned char KEY_NUM = 0;   //������Ű������µļ�ֵ
unsigned long HX711_Buffer = 0;  //�������HX711��ȡ����������
unsigned long Weight_Maopi = 0; //�������ëƤ����
long Weight_Shiwu = 0;          //�������ʵ������
long Max_Value = 0;             //��������������ֵ
char maxValueTable[4] = {1,0,0,0};
unsigned char state = 0;    //�����������״̬
unsigned char Blink_Speed = 0;
#define Blink_Speed_Max 6          //��ֵ���Ըı�����ָ����˸Ƶ��

//У׼����
//�����ֲ��Գ���������ƫ��ʱ�����Ӹ���ֵ��
//������Գ���������ƫСʱ����С����ֵ��
#define GapValue 100

//������������ֵ����λ��g
#define AlarmValue 5000			

//****************************************************
//������
//****************************************************

void weight_initial(void)
{
	Init_LCD1602();						//��ʼ��LCD1602
	LCD1602_write_com(0x80);			//����LCD1602ָ��
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

//        if(Weight_Shiwu >= Max_Value || Weight_Shiwu >= AlarmValue)	        //�����������ֵ���ߴ����������������ֵ����	
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
//����
//****************************************************
void Get_Weight()
{
	Weight_Shiwu = HX711_Read();
	if(Weight_Shiwu >= 0)			
	{	
		Weight_Shiwu = (unsigned long)((float)Weight_Shiwu/GapValue); 	//����ʵ���ʵ������
	}
	else
	{
		Weight_Shiwu = 0;
	}
}



//****************************************************
//MS��ʱ����(12M�����²���)
//****************************************************
void Delay_ms(unsigned int n)
{
	unsigned int  i,j;
	for(i=0;i<n;i++)
		for(j=0;j<123;j++);
}



//****************************************************
//����ɨ�����
//****************************************************
unsigned char Scan_Key()
{	
    if( KEY1 == 0 )						//����ɨ��
	{
		Delay_ms(10);					//��ʱȥ��
		if( KEY1 == 0 )
		{
			Buzzer_Di();
			while(KEY1 == 0);			//�ȴ�����
			return 1;
		}
	}
    if( KEY2 == 0 )						//����ɨ��
	{
		Delay_ms(10);					//��ʱȥ��
		if( KEY2 == 0 )
		{
			Buzzer_Di();
			while(KEY2 == 0);			//�ȴ�����
			return 2;
		}
	}
    if( KEY3 == 0 )						//����ɨ��
	{
		Delay_ms(10);					//��ʱȥ��
		if( KEY3 == 0 )
		{
			Buzzer_Di();
			while(KEY3 == 0);			//�ȴ�����
			return 3;
		}
	}
	if( KEY4 == 0 )						//����ɨ��
	{
		Delay_ms(10);					//��ʱȥ��
		if( KEY4 == 0 )
		{
			Buzzer_Di();
			while(KEY4 == 0);			//�ȴ�����
			return 4;
		}
	}
    return 0;
}
