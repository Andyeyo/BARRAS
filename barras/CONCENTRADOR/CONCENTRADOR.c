#define LED_485 PORTA.RA3
#define LED_TTR PORTA.RA4

#define SWITCH_ON PORTC.RC0 //add PC para leer el estado del Switch de encendido
#define DS_FUENTE PORTB.RB5 //add PC control de desenergización del sistema

//SOFTWARE UART SERIAL
sbit Stx0_pin  at PORTB.B1;
sbit Srx0_pin  at PORTB.B2;
sbit Scts0_pin at Stx0_pin; //PORTA.B2 if separated
sbit Stx0_pin_Direction  at TRISB.B1;
sbit Srx0_pin_Direction  at TRISB.B2;
sbit Scts0_pin_Direction at Stx0_pin_Direction;

//NUEVO PUERTO SERIAL PARA J2(RJ45)
sbit Stx2_pin  at PORTB.B6;
sbit Srx2_pin  at PORTB.B7;
sbit Scts2_pin at Stx2_pin;
sbit Stx2_pin_Direction  at TRISB.B6;
sbit Srx2_pin_Direction  at TRISB.B7;
sbit Scts2_pin_Direction at Stx2_pin_Direction;

//RS-485
sbit rs485_rxtx_pin  at RA2_bit;               // set transcieve pin
sbit rs485_rxtx_pin_direction at TRISA2_bit;   // set transcieve pin direction
char master_rx_dat[7]={0,0,0,0,0,0,0};
char master_tx_dat[6]={0,0,0,0,0,0};
char buffer[50],s_entran[11],s_salen[11],s_bloqueos[11];
unsigned long int entran=0,salen=0,bloqueos=0 , cnt=0;
char fbt=0, pbuffer=0, u=0,  id_slave=0;

char dat[10];                          // add PC
char i,j;
char esclavo = 10;
unsigned long int seg_off = 0;


//array for rs232 tx
unsigned long int counter1=0, counter2=0; //1 for periodic tx - 2 for periodic change data tx
short int ax=0;
unsigned short int ee1[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','1','0','0','0','0','0','0','0',',',13,10};
unsigned short int ee2[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','2','0','0','0','0','0','0','0',',',13,10};
//////////////////////////   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   21 22 23

/**
mensaje de error pc
**/
char msn[5] = {'B','U','C','L','E'};

//blucle de ayuda para impresion ctrl + c y ctrl + v
void imprimirAlerta(char lugar)
{
    //for(u=0;u<5;u++){Suart0_write(msn[u]);}
    SUart0_write(lugar);
    SUart0_write('\r');
    SUart0_write('\n');
}

//peticion de datos
void peticion(char dirEsclavo)
{
    dat[0] = 0xFF;
    dat[1] = 0xFF;
    dat[2] = 0xFF;
    dat[4] = 0;
    dat[5] = 0;
    dat[6] = 0;
    RS485Master_Send(dat,1,dirEsclavo);
    delay_ms(1);
}

//Interrupt
void interrupt()
{
     RS485Master_Receive(master_rx_dat);
}

//MAIN
void main() 
{
    //SW UART
    ADCON1= 0b00001111; // Configure AN pins as digital I/O
    CMCON = 0b00000111; // Disable comparators
    TRISA.RA3=0; TRISA.RA4=0;
    PORTA.RA3=0; PORTA.RA4=0;
    SUart0_Init_T();
    SUart2_Init_T();
    
    TRISC.RC0 = 1;    //add PC para lectura del SW_ON
    PORTC.RC0 = 0;
    TRISB.RB5 = 0;
    PORTB.RB5 = 0;

    //RS485 master
    UART1_Init(9600); Delay_ms(100);                    // initialize UART1 module
    RS485Master_Init(); Delay_ms(100);                  // initialize MCU as Master
    RCIE_bit = 1;                        // enable interrupt on UART1 receive
    TXIE_bit = 0;                        // disable interrupt on UART1 transmit
    PEIE_bit = 1;                        // enable peripheral interrupts
    GIE_bit = 1;                         // enable all interrupts
    
    peticion(esclavo);
    
    while(1)
    {
        //if an error detected
        if (master_rx_dat[5]) 
        {
           LED_TTR=1;
           Delay_ms(10);
           LED_TTR=0;
           master_rx_dat[5]=0;
           master_rx_dat[4]=0;
        }
        
        //in case of crush
        if(fbt>0)
        {
            cnt++;
        }

        if(cnt>14000*1){ //modificado, valor original 14000 * 100
            cnt=0;
            fbt=0;
            LED_485=0;
            pbuffer=0;
            entran=0; salen=0; bloqueos=0;
            
            imprimirAlerta('R'); //addPC
        }

        // if message received successfully
        if (master_rx_dat[4] && !master_rx_dat[5])
        {
            if(fbt==0){
                cnt=0;
                entran=0;
                LED_485=1;
                buffer[pbuffer++]='i';
                id_slave=master_rx_dat[6];
                buffer[pbuffer++]=master_rx_dat[6]+48; //convert unsigned short to ascii char
                entran+=(unsigned long int)master_rx_dat[0];
                entran+=(((unsigned long int)master_rx_dat[1])<<8);
                entran+=(((unsigned long int)master_rx_dat[2])<<16);
                fbt=1;
            }
            else if(fbt==1){
                entran+=(((unsigned long int)master_rx_dat[0])<<24);
                salen+=(unsigned long int)master_rx_dat[1];
                salen+=(((unsigned long int)master_rx_dat[2])<<8);
                fbt=2;
            }
            else if(fbt==2){
                salen+=(((unsigned long int)master_rx_dat[0])<<16);
                salen+=(((unsigned long int)master_rx_dat[1])<<24);
                bloqueos+=(unsigned long int)master_rx_dat[2];
                fbt=3;          //cambiado original 3
            }
            else if(fbt==3){
                bloqueos+=(((unsigned long int)master_rx_dat[1])<<8);
                bloqueos+=(((unsigned long int)master_rx_dat[2])<<16);
                bloqueos+=(((unsigned long int)master_rx_dat[1])<<24);
                fbt=4;
            }
            master_rx_dat[4] = 0; master_rx_dat[6]=0;
        }

        if(fbt==4)
        {
            LED_485=0;
            LongWordToStrWithZeros(entran,s_entran);
            LongWordToStrWithZeros(salen,s_salen);
            LongWordToStrWithZeros(bloqueos,s_bloqueos);
            buffer[pbuffer++]='E';
            for(u=0;u<10;u++){ buffer[pbuffer++]=s_entran[u]; }
            buffer[pbuffer++]='S';
            for(u=0;u<10;u++){ buffer[pbuffer++]=s_salen[u]; }
            buffer[pbuffer++]='B';
            for(u=0;u<10;u++){ buffer[pbuffer++]=s_bloqueos[u]; }
            buffer[pbuffer++]='#';
            SUart0_RstrNout(buffer,36);       //------------envio por bluetooth

            SUart0_write('\r');  //add PC
            SUart0_write('\n');  //add PC

            //especificar '#entran' por barra
            if(id_slave == 10)
            {
                for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
            }
            if(id_slave == 20)
            {
                for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
            }
            
            fbt=0; pbuffer=0;

            entran=0; salen=0; bloqueos=0;
            cnt=0;
        }

        //tx
        counter2++;
        if(counter2>(14000*20))
        {
            counter2=0;
            if(ax==0)
            {
                ax=1;
            }
            else
            {
                ax=0;
            }
            
            //add PC
            imprimirAlerta((esclavo/10)+48);
            peticion(esclavo); //pedido de envio de información
            esclavo += 10;
            if(esclavo > 30)
            {
                esclavo = 10;
            }

        }
        
        counter1++;
        if(counter1>(14000*1))
        {
            counter1=0;
            if(ax==0)
            {
                for(u=0;u<24;u++)
                {
                  Suart2_write((char)ee1[u]); //transmitir por RS232 puerto J2(RJ45) pc
                }
            }
            else
            {
                for(u=0;u<24;u++)
                {
                  Suart2_write((char)ee2[u]); //transmitir por RS232 puerto J2(RJ45) pc
                }
            }
        }
        
        if(SWITCH_ON)   //bucle de lectura de switch_on
        {
            seg_off++;
            //53572 = 1 seg en 30 min se pierden 30 seg
            //54480 = 1 seg en 10 min aumentan 8 seg
            //54026 = 1 seg en 10 min aumenta 1 seg (error 0.1%) +-0.05
            //T = 54026 * 60(seg) * 30(min)
            if((seg_off > (54026 * 10)) && DS_FUENTE == 0) //1 MINUTO (4000 CYCLOS = 1 SEG)
            {
                seg_off = 0;
                DS_FUENTE = 1;
                SUart0_write('A');  //add PC
                SUart0_write('P');  //add PC
                SUart0_write('A');  //add PC
                SUart0_write('G');  //add PC
                SUart0_write('A');  //add PC
                SUart0_write('N');  //add PC
                SUart0_write('D');  //add PC
                SUart0_write('O');  //add PC
                SUart0_write('\r');  //add PC
                SUart0_write('\n');  //add PC
            }
        }
        else //en el caso de volver a encender el sistema, reiniciar contador
        {
            seg_off = 0;
            DS_FUENTE = 0;
        }
    }
}