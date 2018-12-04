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

//Add PC
char dat[10];
char i,j;
char esclavo = 10;
unsigned long int seg_off = 0;

//Array for rs232 tx MVT600 de rasercom
unsigned long int counter1=0, counter2=0; //1 for periodic tx - 2 for periodic change data tx
short int ax=0;
unsigned short int ee1[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','1','0','0','0','0','0','0','0',',',13,10};
unsigned short int ee2[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','2','0','0','0','0','0','0','0',',',13,10};
unsigned short int ee3[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','3','0','0','0','0','0','0','0',',',13,10};
//////////////////////////   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   21 22 23


void buildBuf600();
void imprimirAlerta(char lugar);
void imprimirMensaje(char mensaje[10]);
void peticion(char dirEsclavo);
void transmitirGPS(int GPS);

//Interrupcion del bus RS485
void interrupt()
{
     RS485Master_Receive(master_rx_dat);
}

void main() 
{
    ADCON1= 0b00001111;                     // Configure AN pins as digital I/O
    CMCON = 0b00000111;                     // Disable comparators
    TRISA.RA3=0; TRISA.RA4=0;
    PORTA.RA3=0; PORTA.RA4=0;
    
    //SW UART
    SUart0_Init_T();
    SUart2_Init_T();
    
    TRISC.RC0 = 1;                          //add PC para lectura del SW_ON
    PORTC.RC0 = 0;
    TRISB.RB5 = 0;
    PORTB.RB5 = 0;

    //Configuraciones RS485 (acceso al bus como master)
    UART1_Init(9600); Delay_ms(100);      // initialize UART1 module
    RS485Master_Init(); Delay_ms(100);    // initialize MCU as Master
    RCIE_bit = 1;                         // enable interrupt on UART1 receive
    TXIE_bit = 0;                         // disable interrupt on UART1 transmit
    PEIE_bit = 1;                         // enable peripheral interrupts
    GIE_bit = 1;                          // enable all interrupts
    
    //invocar metodo de peticion de datos al esclavo 10
    peticion(esclavo);
    
    while(1)
    {
        //Si se detecta error en RS485
        if (master_rx_dat[5]) 
        {
           LED_TTR=1;
           Delay_ms(10);
           LED_TTR=0;
           master_rx_dat[5]=0;
           master_rx_dat[4]=0;
        }
        
        //Evalua posibles colapsos
        if(fbt>0)
        {
            cnt++;
        }
        if(cnt>14000*1) //modificado, valor original 14000 * 100
        {
            cnt=0;
            fbt=0;
            LED_485=0;
            pbuffer=0;
            entran=0; salen=0; bloqueos=0;
            
            imprimirAlerta('R'); //addPC
        }

        // Evalua mensajes exitosos
        if (master_rx_dat[4] && !master_rx_dat[5])
        {
            if(fbt==0)
            {
                cnt=0;
                entran=0;
                LED_485=1;
                buffer[pbuffer++]='i';
                id_slave=master_rx_dat[6];
                buffer[pbuffer++]=master_rx_dat[6]+48; //unsigned short a caracter ascii
                entran+=(unsigned long int)master_rx_dat[0];
                entran+=(((unsigned long int)master_rx_dat[1])<<8);
                entran+=(((unsigned long int)master_rx_dat[2])<<16);
                fbt=1;
            }
            else if(fbt==1)
            {
                entran+=(((unsigned long int)master_rx_dat[0])<<24);
                salen+=(unsigned long int)master_rx_dat[1];
                salen+=(((unsigned long int)master_rx_dat[2])<<8);
                fbt=2;
            }
            else if(fbt==2)
            {
                salen+=(((unsigned long int)master_rx_dat[0])<<16);
                salen+=(((unsigned long int)master_rx_dat[1])<<24);
                bloqueos+=(unsigned long int)master_rx_dat[2];
                fbt=3;
            }
            else if(fbt==3)
            {
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
            
            SUart0_RstrNout(buffer,36);             //Transmitir por bluetooth
            SUart0_write('\r'); SUart0_write('\n'); //add PC salto de linea
            
            //Envio a traves del GPS
            //buildBuf600();                      //Construir BUffer para MVT600
            //transmitirGPS(600);                 //ENVIAR POR MVT600
            transmitirGPS(300);               //ENVIAR POR GV300
            
            fbt=0; pbuffer=0;

            entran=0; salen=0; bloqueos=0;
            cnt=0;
        }

        /*
            Se utiliza para enviar solicitud a los esclavos de forma ordenada
            cada 140000*N segundos.
            Nota: Del tiempo entre peticiones descrito, depende la recepcion por
            RS485 y envio a traves de Bluetooth Y GPS.
            A mayor tiempo, mayor retardo en el envio por GPS y viceversa.
        */
        counter2++;
        if(counter2>(140000*3))
        {
            counter2=0;
            
            //Realizar pedido de informacion al esclavo de forma ordenada
            imprimirAlerta((esclavo/10)+48);
            peticion(esclavo);              //pedido de información al esclavo
            esclavo += 10;                  //incrementar direccion de esclavo
            if(esclavo > 30){esclavo = 10;} //control desborde de esclavos
        }

        /*
            Bucle de envío por GPS cada X segundos
            Nota: generalmente se usa con el MVT600 y requiere que en FBT = 4
            se invoque al metodo "buildBuf600()" para que se construya el buffer
            de cada una de las barras.
        */
        counter1++;
        if(counter1>(140000*20))
        {
            counter1=0;
            //transmitirGPS(600); //INVOCAR ENVIO GPS MVT600
        }
        
        
        /*
            Bucle de lectura de switch_on, para controlar el control del
            RELAY de desconexion
        */
        if(SWITCH_ON)
        {
            seg_off++;
            //53572 = 1 seg en 30 min se pierden 30 seg
            //54480 = 1 seg en 10 min aumentan 8 seg
            //54026 = 1 seg en 10 min aumenta 1 seg (error 0.1%) +-0.05
            //T = 54026 * 60(seg) * 30(min)
            if((seg_off > (54026 * 10)) && DS_FUENTE == 0)
            {
                seg_off = 0;
                DS_FUENTE = 1;
                SUart0_write('O');  SUart0_write('F'); SUart0_write('F'); //off
                SUart0_write('\r');
                SUart0_write('\n');            
            }

        }
        else //en el caso de volver a encender el sistema, reiniciar contador
        {
            seg_off = 0;
            DS_FUENTE = 0;
        }
    }
}


/*
    Ayuda para impresion de eventos
    Obtiene:    Caracter especifico a mostrar
    Retorna:    Nada
*/
void imprimirAlerta(char lugar)
{
    SUart0_write(lugar);
    SUart0_write('\r');
    SUart0_write('\n');
}
void imprimirMensaje(char mensaje[10])
{
    int u = 0;
    for(u = 0; u < 10; u++)
    {
        SUart0_write(mensaje[u]);
    }
    SUart0_write('\r');
    SUart0_write('\n');
}


/*--------------peticion de datos a la direccion de esclavo------------------
    Cada esclavo obtiene un mensaje de verificacion de peticion de datos, que
    actualmente es el valor 0xFF en la posicion ZERO del mensaje de peticion.
    En el esclavo, el mensaje es validado y de comprobarse el valor 0xFF
    retorna el valos de conteo que tenga guardado en memoria.
    Obtiene:    direccion del esclavo en formato caracter
                10, 20, 30
    Retorna:    Nada
*/
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


/*
    Construir buffer de transmision para GPS MVT600 de rasercom,
    especificando unicamente las entradas contabilizadas por cada
    barra
    Obtiene:    Nada
    Retorna:    Nada
*/
void buildBuf600()
{
    if(id_slave == 10)
    {
        for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
    }
    if(id_slave == 20)
    {
        for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
    }
    if(id_slave == 30)
    {
        for(u=3;u<10;u++){ ee3[11+u]=s_entran[u]; }
    }
}


/*
    Transmision de datos por puerto RS232
    Obtiene:    Valor en enteros del nombre del dispositivo GPS utilizado
                300 para GV300
                600 para MVT600
    Retorna:    Nada
    
    Nota:       La variable AX ha sido utilizada para cambiar el buffer a
                enviar usualmente se utiliza para trabajar con MVT600
*/
void transmitirGPS(int GPS)
{
    if(GPS == 300)      // PARA GV300
    {
        for(u=0;u<36;u++)
        {
            Suart2_write((char)buffer[u]); //TX por RS232 puerto J2(RJ45) pc
        }
    }
    
    else if(GPS == 600) // PARA MVT600
    {
        if(ax==0)
        {
            ax = 1;
            for(u=0;u<24;u++)
            {
                Suart2_write((char)ee1[u]); //TX por RS232 puerto J2(RJ45) pc
            }
        }
        else if (ax == 1)
        {
            ax = 2;
            for(u=0;u<24;u++)
            {
                Suart2_write((char)ee2[u]); //TX por RS232 puerto J2(RJ45) pc
            }
        }
        else if (ax == 2)
        {
            ax = 0;
            for(u=0;u<24;u++)
            {
                Suart2_write((char)ee3[u]); //TX por RS232 puerto J2(RJ45) pc
            }
        }
    }
}