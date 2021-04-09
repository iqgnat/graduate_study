#include <reg51.h>
#include "LCD.h"
		void main(void)
		   {
		     LCD_init();
		
		   while(1)
		      {
		      write_string(0x00,"Test");
			  //Scan_Key();
		      }
		   }