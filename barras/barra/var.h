//variables contadoras
unsigned long int NUMPER;
unsigned long int ENTRAN;
unsigned long int SALEN;
unsigned long int BLOQUEOS;
//bloqueos
unsigned long int contador;
unsigned short int contador_seg;
bit bk; //flag
//leds
unsigned short int aa,bb,cc,dd,ee; //flags para leds infrarrojos
//log
unsigned short int logA[100];
unsigned short int logAindex;
unsigned short int logB[100];
unsigned short int logBindex;
unsigned short int logC;
bit pp; //variable para presencia
unsigned short int pos;
signed short int Apm,Apn,Apx,Apy;
signed short int Bpm,Bpn,Bpx,Bpy;
//counter
char resultadoA;
char resultadoB;
char resultadoT;
//rs485
char slave_tx_dat[7];
char slave_rx_dat[6];
sbit  rs485_rxtx_pin at RA2_bit;             // set transcieve pin
sbit  rs485_rxtx_pin_direction at TRISA2_bit;   // set transcieve pin direction
// without log
unsigned short int iyn;
unsigned long int ixm;
unsigned short int sumi;
unsigned short int jyn;
unsigned long int jxm;
unsigned short int sumj;

//SOFTWARE UART SERIAL
sbit Stx0_pin  at PORTA.B1;
sbit Srx0_pin  at PORTA.B0;
sbit Scts0_pin at Stx0_pin; //PORTA.B2 if separated
sbit Stx0_pin_Direction  at TRISA.B1;
sbit Srx0_pin_Direction  at TRISA.B0;
sbit Scts0_pin_Direction at Stx0_pin_Direction;

//add PC
int idEsclavo; //identificador del esclavo leido a traves de switch