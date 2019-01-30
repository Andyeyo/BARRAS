#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/block.c"
#line 1 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/extern.h"
#line 36 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/extern.h"
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
#line 4 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/block.c"
void bloqueo(void)
{
 contador++;
 if (contador>= 28000 )
 {
 contador=0;
 if(aa+bb+cc+dd+ee<=6 && bk==1)
 {
 SUart0_Write('B');
 SUart0_Write('\r');
 SUart0_Write('\n');

 contador_seg++;
 if(contador_seg==5)
 {
 BLOQUEOS++;
 }
 }
 }

 if((contador==0 || contador==( 28000 *0.5)) && (contador_seg>=5))
 {
  PORTD.RD2 =1;
 }

 if((contador==( 28000 *0.17) || contador==( 28000 *0.67)) && (contador_seg>=5))
 {
  PORTD.RD2 =0;
 }
}
