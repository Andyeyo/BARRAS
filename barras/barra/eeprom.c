#include "extern.h"

void save_data(void)
{
    write_long(80,ENTRAN);
    write_long(84,SALEN);
    write_long(88,BLOQUEOS);
    write_long(92,555);
    Delay_ms(20);
}

void read_data(void)
{
    ENTRAN=read_long(80);
    SALEN=read_long(84);
    BLOQUEOS=read_long(88);
    Delay_ms(20);
}

void write_long(unsigned int addr, unsigned long int four_byte)
{
    unsigned char f_byte;
    unsigned char s_byte;
    unsigned char t_byte;
    unsigned char fth_byte;

    f_byte=four_byte&0xFF;
    s_byte=(four_byte&0xFF00)>>8;
    t_byte=(four_byte&0xFF0000)>>16;
    fth_byte=(four_byte&0xFF000000)>>24;

    EEPROM_Write (addr++,fth_byte);
    EEPROM_Write (addr++,t_byte);
    EEPROM_Write (addr++,s_byte);
    EEPROM_Write (addr,f_byte);
}

unsigned long int read_long(unsigned int addr)
{
    unsigned long int res=0;
    res+=(((unsigned long int)EEPROM_Read(addr++))<<24);
    res+=(((unsigned long int)EEPROM_Read(addr++))<<16);
    res+=(((unsigned long int)EEPROM_Read(addr++))<<8);
    res+=(unsigned long int)EEPROM_Read(addr);
    return res;
}