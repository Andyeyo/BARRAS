#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/setup.c"
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
#line 3 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/setup.c"
void init_485(void);
void init_var(void);
void init_led(void);

void init_setup(void){


 NUMPER = 0;
 if(read_long(92)==555){
 read_data();
 }
 else{
 SALEN = 0;
 ENTRAN = 0;
 BLOQUEOS = 0;
 save_data();
 }

 ADCON1= 0b00001111;
 CMCON = 0b00000111;

 PORTA = 0;
 PORTB = 0;
 PORTC = 0;
 PORTD = 0;
 PORTE = 0;

 TRISA = 0b11011011;
 TRISB = 0b11111001;
 TRISC = 0b11011011;
 TRISD = 0b11011011;
 TRISE = 0b00000110;


 init_led();
 init_485();
 init_var();

 logA_reset();
 logB_reset();


 PWM1_Init(36000);
 PWM1_Set_Duty(25);
 PWM1_Start();


 SUart0_Init_T();

 Delay_ms(100);
}

void init_485(void)
{
#line 72 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/setup.c"
}

void init_var(void){


 contador = 0;
 contador_seg = 0;
 bk = 0;


 iyn = 0;
 ixm = 0;
 sumi = 1;
 jyn = 0;
 jxm = 0;
 sumj = 1;


 aa=2;
 bb=2;
 cc=2;
 dd=2;
 ee=2;


 logA[100];
 logAindex=100;
 logB[100];
 logBindex=100;
 logC=0;
 pp=0;
 pos=0;
 Apm=-1; Apn=-1; Apx=-1; Apy=-1;
 Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;


 resultadoA='X';
 resultadoB='X';
 resultadoT='X';

}

void init_led(void){
  PORTD.RD5  = 1;
  PORTE.RE0  = 1;
  PORTC.RC5  = 0;
  PORTA.RA5  = 0;

 Delay_ms(500);

  PORTE.RE0  = 0;
  PORTC.RC5  = 1;
  PORTA.RA5  = 0;

 Delay_ms(500);

  PORTE.RE0  = 0;
  PORTC.RC5  = 0;
  PORTA.RA5  = 1;

 Delay_ms(500);

  PORTE.RE0  = 1;
  PORTC.RC5  = 1;
  PORTA.RA5  = 1;

}


char leerIdSlave(void)
{
 if( PORTC.B1  == 0 &&  PORTC.B0  == 0)
 {
 idEsclavo = 10;
 }
 else if( PORTC.B1  == 0 &&  PORTC.B0  == 1)
 {
 idEsclavo = 20;
 }
 else if( PORTC.B1  == 1 &&  PORTC.B0  == 0)
 {
 idEsclavo = 30;
 }
 else if( PORTC.B1  == 1 &&  PORTC.B0  == 1)
 {
 idEsclavo = 40;
 }
 return idEsclavo;
}
