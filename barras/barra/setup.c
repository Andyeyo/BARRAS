#include "extern.h"

void init_485(void);
void init_var(void);
void init_led(void);

void init_setup(void){

    //variables contadoras
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

    TRISA = 0b11011011; // salidas =0  entradas=1
    TRISB = 0b11111001;
    TRISC = 0b11011011;
    TRISD = 0b11011011;
    TRISE = 0b00000110;
    
    ADCON1= 0b00001111; // Configure AN pins as digital I/O
    CMCON = 0b00000111; // Disable comparators

    //SUart0_Init_T(); //SW UART
    init_led();
    init_485();
    init_var();
    
    logA_reset();
    logB_reset();

    //PWM
    PWM1_Init(36000);
    PWM1_Set_Duty(25);
    PWM1_Start();

    Delay_ms(100);
}

void init_485(void){
    UART1_Init(9600);                  // initialize UART1 module
    Delay_ms(100);
    RS485Slave_Init(slave_id);              // Intialize MCU as slave, address 160

    //Uart interrupts
    RCIE_bit = 0;                      // enable interrupt on UART1 receive
    TXIE_bit = 0;                      // disable interrupt on UART1 transmit

    //disable interrupts
    PEIE_bit = 0;                      // disable peripheral interrupts
    GIE_bit = 0;                       // disable all interrupts
}

void init_var(void){

    //bloqueos
    contador = 0;
    contador_seg = 0;
    bk = 0; //flag
    
    //without log
    iyn = 0;
    ixm = 0;
    sumi = 1;
    jyn = 0;
    jxm = 0;
    sumj = 1;

    //leds
    aa=2;
    bb=2;
    cc=2;
    dd=2;
    ee=2;

    //log
    logA[100];
    logAindex=100;
    logB[100];
    logBindex=100;
    logC=0;
    pp=0; //variable para presencia
    pos=0;
    Apm=-1; Apn=-1; Apx=-1; Apy=-1;
    Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;

    //counter
    resultadoA='X';
    resultadoB='X';
    resultadoT='X';

}

void init_led(void){
    BUZZER = 1; //ADD PC
    LED_V = 1;
    LED_A = 0;
    LED_R = 0;
 //   BUZZER = 0;
   Delay_ms(500);

    LED_V = 0;
    LED_A = 1;
    LED_R = 0;
//    BUZZER = 1;
    Delay_ms(500);

    LED_V = 0;
    LED_A = 0;
    LED_R = 1;
//    BUZZER = 0;
    Delay_ms(500);

    LED_V = 1;
    LED_A = 1;
    LED_R = 1;
//    BUZZER = 1;
}