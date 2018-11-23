#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/CONCENTRADOR/CONCENTRADOR.c"







sbit Stx0_pin at PORTB.B1;
sbit Srx0_pin at PORTB.B2;
sbit Scts0_pin at Stx0_pin;
sbit Stx0_pin_Direction at TRISB.B1;
sbit Srx0_pin_Direction at TRISB.B2;
sbit Scts0_pin_Direction at Stx0_pin_Direction;


sbit Stx2_pin at PORTB.B6;
sbit Srx2_pin at PORTB.B7;
sbit Scts2_pin at Stx2_pin;
sbit Stx2_pin_Direction at TRISB.B6;
sbit Srx2_pin_Direction at TRISB.B7;
sbit Scts2_pin_Direction at Stx2_pin_Direction;


sbit rs485_rxtx_pin at RA2_bit;
sbit rs485_rxtx_pin_direction at TRISA2_bit;
char master_rx_dat[7]={0,0,0,0,0,0,0};
char master_tx_dat[6]={0,0,0,0,0,0};
char buffer[50],s_entran[11],s_salen[11],s_bloqueos[11];
unsigned long int entran=0,salen=0,bloqueos=0 , cnt=0;
char fbt=0, pbuffer=0, u=0, id_slave=0;

char dat[10];
char i,j;
char esclavo = 10;
unsigned long seg_off = 0;



unsigned long int counter1=0, counter2=0;
short int ax=0;
unsigned short int ee1[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','1','0','0','0','0','0','0','0',',',13,10};
unsigned short int ee2[24]={'r','a','s','e','r','c','o','m','.','R','S','C',',','2','0','0','0','0','0','0','0',',',13,10};
#line 48 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/CONCENTRADOR/CONCENTRADOR.c"
char msn[5] = {'B','U','C','L','E'};


void imprimirAlerta(char lugar)
{

 SUart0_write(lugar);
 SUart0_write('\r');
 SUart0_write('\n');
}


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


void interrupt()
{
 RS485Master_Receive(master_rx_dat);
}


void main()
{

 ADCON1= 0b00001111;
 CMCON = 0b00000111;
 TRISA.RA3=0; TRISA.RA4=0;
 PORTA.RA3=0; PORTA.RA4=0;
 SUart0_Init_T();
 SUart2_Init_T();

 TRISC.RC0 = 1;
 PORTC.RC0 = 0;
 TRISB.RB5 = 0;
 PORTB.RB5 = 0;


 UART1_Init(9600); Delay_ms(100);
 RS485Master_Init(); Delay_ms(100);
 RCIE_bit = 1;
 TXIE_bit = 0;
 PEIE_bit = 1;
 GIE_bit = 1;

 peticion(esclavo);

 while(1)
 {

 if (master_rx_dat[5])
 {
  PORTA.RA4 =1;
 Delay_ms(10);
  PORTA.RA4 =0;
 master_rx_dat[5]=0;
 master_rx_dat[4]=0;
 }


 if(fbt>0)
 {
 cnt++;
 }

 if(cnt>14000*1){
 cnt=0;
 fbt=0;
  PORTA.RA3 =0;
 pbuffer=0;
 entran=0; salen=0; bloqueos=0;

 imprimirAlerta('R');
 }


 if (master_rx_dat[4] && !master_rx_dat[5])
 {
 if(fbt==0){
 cnt=0;
 entran=0;
  PORTA.RA3 =1;
 buffer[pbuffer++]='i';
 id_slave=master_rx_dat[6];
 buffer[pbuffer++]=master_rx_dat[6]+48;
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
 fbt=3;
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
  PORTA.RA3 =0;
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
 SUart0_RstrNout(buffer,36);

 SUart0_write('\r');
 SUart0_write('\n');


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


 imprimirAlerta((esclavo/10)+48);
 peticion(esclavo);
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
 Suart2_write((char)ee1[u]);
 }
 }
 else
 {
 for(u=0;u<24;u++)
 {
 Suart2_write((char)ee2[u]);
 }
 }
 }

 if( PORTC.RC0 )
 {
 seg_off++;
 if(seg_off > 4000 * 60)
 {
 seg_off = 0;
  PORTB.RB5  = 1;
 SUart0_write('A');
 SUart0_write('P');
 SUart0_write('A');
 SUart0_write('G');
 SUart0_write('A');
 SUart0_write('N');
 SUart0_write('D');
 SUart0_write('O');
 SUart0_write('\r');
 SUart0_write('\n');
 }
 }
 else
 {
 seg_off = 0;
  PORTB.RB5  = 0;
 }
 }
}
