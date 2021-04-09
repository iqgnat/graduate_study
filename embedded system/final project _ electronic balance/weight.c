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
#define GapValue 430

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
	/*Get_Maopi();
	Get_Maopi();
	Delay_ms(2000);		 //��ʱ
	Get_Maopi();
	Get_Maopi();				//��β���������HX711�ȶ�
  LCD1602_write_com(0x01);    //����
    //��ȡEEPROM�б���ı���ֵ
    maxValueTable[0] = byte_read(0x2000);
    maxValueTable[1] = byte_read(0x2001);
    maxValueTable[2] = byte_read(0x2002);
    maxValueTable[3] = byte_read(0x2003);
    Max_Value = maxValueTable[0]*1000+maxValueTable[1]*100+maxValueTable[2]*10+maxValueTable[3];    //���㳬�ޱ�������ֵ
	
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
                Max_Value = maxValueTable[0]*1000+maxValueTable[1]*100+maxValueTable[2]*10+maxValueTable[3];    //���㳬�ޱ�������ֵ
            }
        }
        if(KEY_NUM == 2)        //������
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
        if(KEY_NUM == 3)        //������
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
			Get_Maopi();			//ȥƤ	
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
        
        //���ޱ���
        if(Weight_Shiwu >= Max_Value || Weight_Shiwu >= AlarmValue)	        //�����������ֵ���ߴ����������������ֵ����	
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
//����
//****************************************************
void Get_Weight()
{
	Weight_Shiwu = HX711_Read();
	Weight_Shiwu = Weight_Shiwu - Weight_Maopi;		//��ȡ����
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
//��ȡëƤ����
//****************************************************
void Get_Maopi()
{
	Weight_Maopi = HX711_Read();	
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
//����������
//****************************************************
void Buzzer_Di()
{
	Buzzer = 0;
	Delay_ms(10);
	Buzzer = 1;
	Delay_ms(10);
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
