//define
#define slave_id 10
#define BUZZER PORTD.RD5
#define DET1 PORTA.RA4
#define DET2 PORTA.RA3
#define DET3 PORTE.RE1
#define DET4 PORTB.RB7
#define DET5 PORTB.RB6

#define OPTO PORTE.RE2
#define RJ45 PORTD.RD6
#define LED_V PORTE.RE0
#define LED_R PORTA.RA5
#define LED_A PORTC.RC5

#define jumper1 PORTD.RD3 // PARA QUE SE ELIJA EL SENTIDO DE LAS DIRECCIONES
#define jumper2 PORTC.RC4 // PARA QUE CUENTE SOLO EN UNA DIRECCION
#define jumper3 PORTD.RD4 // PARA QUE CUENTE SOLO EN UNA DIRECCION original pin d4


///////////////////////////////////////////////////////////////77
//extern hace a las variables que se puedan usar globalmente
//solo se declaran 1 vez en otro header y cualquier .c que desee
//ocuparla debe incluir este .h
//Este compilador despues de ejecutar el main ejecuta los demas .c
//////////////////////////////////////////////////////////////

//VARIABLES////////////////////////////////////////////////////////

//variables contadoras
extern unsigned long int NUMPER;
extern unsigned long int ENTRAN;
extern unsigned long int SALEN;
extern unsigned long int BLOQUEOS;
//bloqueos
extern unsigned int contador;
extern unsigned short int contador_seg;
extern bit bk; //flag
//leds
extern unsigned short int aa,bb,cc,dd,ee; //flags para leds infrarrojos
//log
extern unsigned short int logA[100];
extern unsigned short int logAindex;
extern unsigned short int logB[100];
extern unsigned short int logBindex;
extern unsigned short int logC;
extern bit pp; //variable para presencia
extern unsigned short int pos;
extern signed short int Apm,Apn,Apx,Apy;
extern signed short int Bpm,Bpn,Bpx,Bpy;
//counter
extern char resultadoA;
extern char resultadoB;
extern char resultadoT;
//rs485
extern char slave_tx_dat[7];
extern char slave_rx_dat[6];
// without log
extern unsigned short int iyn;
extern unsigned long int ixm;
extern unsigned short int sumi;
extern unsigned short int jyn;
extern unsigned long int jxm;
extern unsigned short int sumj;

//METODOS//////////////////////////////////////////////////////
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