#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/rs485.c"
#line 1 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/extern.h"
#line 34 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/extern.h"
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
#line 3 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/rs485.c"
void byte_send(char pkg);
void wait_for_bus();
void tx_prepare(char p0, char p1, char p2);

void rs485_slave_send(void)
{
 unsigned int u;
 unsigned short e0,e1,e2,e3,s0,s1,s2,s3,b0,b1,b2,b3;
#line 18 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/rs485.c"
 e0=ENTRAN&0xFF;
 e1=(ENTRAN&0xFF00)>>8;
 e2=(ENTRAN&0xFF0000)>>16;
 e3=(ENTRAN&0xFF000000)>>24;

 s0=SALEN&0xFF;
 s1=(SALEN&0xFF00)>>8;
 s2=(SALEN&0xFF0000)>>16;
 s3=(SALEN&0xFF000000)>>24;

 b0=BLOQUEOS&0xFF;
 b1=(BLOQUEOS&0xFF00)>>8;
 b2=(BLOQUEOS&0xFF0000)>>16;
 b3=(BLOQUEOS&0xFF000000)>>24;

 tx_prepare(e0,e1,e2);
 RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
 tx_prepare(e3,s0,s1);
 RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
 tx_prepare(s2,s3,b0);
 RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
 tx_prepare(b1,b2,b3);
 RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
}

void byte_send(char pkg){


 char x, f=0;
#line 59 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/rs485.c"
}

void tx_prepare(char p0, char p1, char p2)
{
 slave_tx_dat[0]=p0;
 slave_tx_dat[1]=p1;
 slave_tx_dat[2]=p2;
 slave_tx_dat[3]=0;
 slave_tx_dat[4]=0;
 slave_tx_dat[5]=0;
 slave_tx_dat[6]=0;
}
