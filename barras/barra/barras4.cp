#line 1 "D:/VICENTE/Documents/CODIGOS_C/GIT_BARRAS/barras/barra/barras4.c"
#line 1 "d:/vicente/documents/codigos_c/git_barras/barras/barra/var.h"

unsigned long int NUMPER;
unsigned long int ENTRAN;
unsigned long int SALEN;
unsigned long int BLOQUEOS;

unsigned long int contador;
unsigned short int contador_seg;
bit bk;

unsigned short int aa,bb,cc,dd,ee;

unsigned short int logA[100];
unsigned short int logAindex;
unsigned short int logB[100];
unsigned short int logBindex;
unsigned short int logC;
bit pp;
unsigned short int pos;
signed short int Apm,Apn,Apx,Apy;
signed short int Bpm,Bpn,Bpx,Bpy;

char resultadoA;
char resultadoB;
char resultadoT;

char slave_tx_dat[7];
char slave_rx_dat[6];
sbit rs485_rxtx_pin at RA2_bit;
sbit rs485_rxtx_pin_direction at TRISA2_bit;

unsigned short int iyn;
unsigned long int ixm;
unsigned short int sumi;
unsigned short int jyn;
unsigned long int jxm;
unsigned short int sumj;


sbit Stx0_pin at PORTA.B1;
sbit Srx0_pin at PORTA.B0;
sbit Scts0_pin at Stx0_pin;
sbit Stx0_pin_Direction at TRISA.B1;
sbit Srx0_pin_Direction at TRISA.B0;
sbit Scts0_pin_Direction at Stx0_pin_Direction;
#line 1 "d:/vicente/documents/codigos_c/git_barras/barras/barra/extern.h"
#line 31 "d:/vicente/documents/codigos_c/git_barras/barras/barra/extern.h"
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
#line 6 "D:/VICENTE/Documents/CODIGOS_C/GIT_BARRAS/barras/barra/barras4.c"
void main() {
 init_setup();
 SUart0_Init_T();
 while(1){
 detect();
 if( PORTD.RD6 ){
 bloqueo();
 counter();
 }

 }
}
