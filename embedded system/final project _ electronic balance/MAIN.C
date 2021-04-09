		#include "Main.h"  
		#include "0_01_12g.h"
		#include "Delay_ms.h"
//		#include <stdlib.h>
//		#include <stdio.h>
		#include <string.h>

		void main(void)
		   {
		     weight_initial();
				 SCH_Init_T0();
				 SCH_Add_Task(weight_update, 1000, 20000); 
		     SCH_Start();
		
		   while(1)
		      {
		      SCH_Dispatch_Tasks();
		      }
		   }
		
