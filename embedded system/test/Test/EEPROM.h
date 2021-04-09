#ifndef __EEPROM_H__
#define __EEPROM_H__

#include <intrins.h>
#include <Sch51.h>

#define uchar unsigned char
#define uint unsigned int 
#define RdCommand 0x01 //??ISP?????
#define PrgCommand 0x02
#define EraseCommand 0x03 
#define Error 1
#define Ok 0
#define WaitTime 0x01 //??CPU?????
sfr ISP_DATA=0xe2;  //?????
sfr ISP_ADDRH=0xe3;
sfr ISP_ADDRL=0xe4;
sfr ISP_CMD=0xe5;
sfr ISP_TRIG=0xe6;
sfr ISP_CONTR=0xe7;

extern void ISP_IAP_enable(void);
extern void ISP_IAP_disable(void);
extern void ISPgoon(void);
extern unsigned char byte_read(unsigned int byte_addr);
extern void SectorErase(unsigned int sector_addr);
extern void byte_write(unsigned int byte_addr, unsigned char original_data);


#endif