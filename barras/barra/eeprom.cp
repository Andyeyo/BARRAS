#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/eeprom.c"
#line 1 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/extern.h"
#line 33 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/extern.h"
extern unsigned long int NUMPER;
extern unsigned long int ENTRAN;
extern unsigned long int SALEN;
extern unsigned long int BLOQUEOS;

extern unsigned int contador;
extern unsigned short int contador_seg;
extern bit bk;

extern unsigned short int aa,bb,cc,dd,ee;

extern unsigned short int logA[100];
extern unsigned short int logAindex;
extern unsigned short int logB[100];
extern unsigned short int logBindex;
extern unsigned short int logC;
extern bit pp;
extern unsigned short int pos;
extern signed short int Apm,Apn,Apx,Apy;
extern signed short int Bpm,Bpn,Bpx,Bpy;

extern char resultadoA;
extern char resultadoB;
extern char resultadoT;

extern char slave_tx_dat[7];
extern char slave_rx_dat[6];

extern unsigned short int iyn;
extern unsigned long int ixm;
extern unsigned short int sumi;
extern unsigned short int jyn;
extern unsigned long int jxm;
extern unsigned short int sumj;


void logA_append(unsigned short num);
void logA_reset();
void logA_dir();
void logB_append(unsigned short num);
void logB_reset();
void logB_dir();
void bloqueo(void);
void detect(void);
void init_setup(void);
void counter(void);
void rs485_slave_send(void);
void save_data(void);
void read_data(void);
void write_long(unsigned int addr, unsigned long int four_byte);
unsigned long int read_long(unsigned int addr);


extern char leerIdSlave(void);
extern char idEsclavo;
#line 3 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/eeprom.c"
void save_data(void){
 write_long(80,ENTRAN);
 write_long(84,SALEN);
 write_long(88,BLOQUEOS);
 write_long(92,555);
 Delay_ms(20);
}

void read_data(void){
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
