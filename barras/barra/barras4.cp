#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
#line 1 "d:/vicente/downloads/pc/algoritmos_codigos/git_github/barras/barras/barra/var.h"

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


int idEsclavo;
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
#line 6 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
int cntax = 0;
char cadenaF[4];
unsigned long xx=0;
char DIN, i, j;

char datoRecibido[9];
void verificarPeticion(char dat[9]);
void indicadorOcupado(void);
int almacenarDatos(void);
int guardado_flag;


void interrupt()
{
 RS485Slave_Receive(datoRecibido);
}

void main()
{
 init_setup();


 UART1_Init(9600);
 Delay_ms(100);
 RS485Slave_Init(leerIdSlave());


 slave_rx_dat[4] = 0;
 slave_rx_dat[5] = 0;
 slave_rx_dat[6] = 0;

 RCIE_bit = 1;
 TXIE_bit = 0;
 PEIE_bit = 1;
 GIE_bit = 1;


 SUart0_Write('E');
 SUart0_Write('S');
 SUart0_Write((leerIdSlave()/10)+48);
 SUart0_Write('\r');
 SUart0_Write('\n');

 read_data();

 while(1)
 {
 detect();
 if( PORTD.RD6 )
 {
 bloqueo();
 counter();
 }
#line 64 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
 while(! PORTD.B1 )
 {
 SUart0_Write('S');
 SUart0_Write('I');
 SUart0_Write('N');
 SUart0_Write('\r');
 SUart0_Write('\n');
#line 76 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
 if(almacenarDatos() == 1 && guardado_flag == 0)
 {
 SUart0_Write('G');
 SUart0_Write('O');
 SUart0_Write('K');
 SUart0_Write('\r');
 SUart0_Write('\n');
 guardado_flag = 1;
 }
 }
#line 89 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
 if( PORTD.B1 )
 {
 guardado_flag = 0;
 PORTD.B1 = 0;
 }
#line 97 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
 if(! PORTA.RA4  && ! PORTA.RA3  && ! PORTE.RE1  && ! PORTB.RB7  && ! PORTB.RB6 )
 verificarPeticion(datoRecibido);
 else
 indicadorOcupado();

 }
}

void verificarPeticion(char dat[9])
{
 if (datoRecibido[5])
 {
 datoRecibido[5] = 0;
 }
 if (datoRecibido[4])
 {
 PORTB.B1 = 1; PORTB.B2 = 1;
 datoRecibido[4] = 0;
 j = datoRecibido[0];
 if(j = 0xFF)
 {
 rs485_slave_send();
 PORTB.B1 = 0; PORTB.B2 = 0;
 }
 else
 {
 SUart0_Write('N');
 SUart0_Write('P');
 SUart0_Write('I');
 SUart0_Write('\r');
 SUart0_Write('\n');
 }
 }
}

int almacenarDatos(void)
{
 unsigned long int V_in,V_sal,V_bloc;

 V_in = ENTRAN;
 V_sal = SALEN;
 V_bloc = BLOQUEOS;

 save_data();


 read_data();

 if(ENTRAN == V_in && SALEN == V_sal && BLOQUEOS == V_bloc)
 {
 return 1;
 }
 else
 {
 ENTRAN = V_in;
 SALEN = V_sal;
 BLOQUEOS = V_bloc;
#line 155 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
 return 0;
 }
}

void indicadorOcupado()
{
#line 168 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/barras4.c"
 PORTB.B1 = ~PORTB.B1;
}
