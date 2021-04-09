#ifndef __HX711_H__
#define __HX711_H__


#include "at89x52.h"
#include <intrins.h>

//IO??
sbit HX711_DOUT=P3^3; 
sbit HX711_SCK=P3^2; 

//????????
extern void Delay__hx711_us(void);
extern unsigned long HX711_Read(void);

#endif