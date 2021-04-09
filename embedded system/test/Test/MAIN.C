		#include "Main.h"  
		#include "0_01_12g.h"
		#include "Delay_ms.h"
//		#include <stdlib.h>
//		#include <stdio.h>
		#include <string.h>
		
    sbit pa = P2^3;
		void main(void)
		   {
		     weight_initial();
				 SCH_Init_T0();
				 SCH_Add_Task(weight_update, 0, 200); 
		     SCH_Start();
		
		   while(1)
		      {
		      SCH_Dispatch_Tasks();
		      }
		   }
		
