#include "extern.h"

void byte_send(char pkg);
void wait_for_bus();
void tx_prepare(char p0, char p1, char p2);

/*// Interrupt routine
void interrupt() {
    RS485Slave_Receive(slave_rx_dat);
}*/

void rs485_slave_send(void){
    unsigned int u;
    unsigned short e0,e1,e2,e3,s0,s1,s2,s3,b0,b1,b2,b3;

   // wait_for_bus();
    
    e0=ENTRAN&0xFF;
    e1=(ENTRAN&0xFF00)>>8;
    e2=(ENTRAN&0xFF0000)>>16;
    e3=(ENTRAN&0xFF000000)>>24;
    s0=SALEN&0xFF;
    s1=(SALEN&0xFF00)>>8;
    s2=(SALEN&0xFF0000)>>16;
    s3=(SALEN&0xFF000000)>>24;
    b0=BLOQUEOS&0xFF;
    b1=(BLOQUEOS&0xFF00)>>8;
    b2=(BLOQUEOS&0xFF0000)>>16;
    b3=(BLOQUEOS&0xFF000000)>>24;
    
    tx_prepare(e0,e1,e2);
    RS485Slave_Send(slave_tx_dat,3); Delay_ms(1);     //tiempo cambiado de 3 a 2 ms
    tx_prepare(e3,s0,s1);
    RS485Slave_Send(slave_tx_dat,3); Delay_ms(1);
    tx_prepare(s2,s3,b0);
    RS485Slave_Send(slave_tx_dat,3); Delay_ms(1);
    tx_prepare(b1,b2,b3);
    RS485Slave_Send(slave_tx_dat,3); Delay_ms(1);
    
    /*//ENVÍO
    LongWordToStrWithZeros(ENTRAN,s_entran);
    LongWordToStrWithZeros(SALEN,s_salen);
    LongWordToStrWithZeros(BLOQUEOS,s_bloqueos);
    tx_prepare(0);
    wait_for_bus();

    byte_send('E');
    for(u=0;u<10;u++){ byte_send(s_entran[u]); }
    byte_send('S');
    for(u=0;u<10;u++){ byte_send(s_salen[u]); }
    byte_send('B');
    for(u=0;u<10;u++){ byte_send(s_bloqueos[u]); }
    byte_send('#');*/
}

/*void wait_for_bus(){
    unsigned int u=0;
    while(1){
        if(PORTC.RC7==1){u++;}else{u=0;}
        if(u>(35+slave_id*2)){break;}
    }
}*/

void byte_send(char pkg){
    //whe only have to edit msg bytes
    //SUart0_Write(pkg);
    char x, f=0;
/*for(x=0;x<3;x++){
        if(slave_tx_dat[x]==0){slave_tx_dat[x]=pkg; f=1; break;}
    }
    if(f==0){
        RS485Slave_Send(slave_tx_dat,3);
        Delay_ms(100);
        tx_prepare(pkg);
    }
    if(pkg=='#'){
        Delay_ms(100);
        RS485Slave_Send(slave_tx_dat,3);
    }*/
}
void tx_prepare(char p0, char p1, char p2){
    slave_tx_dat[0]=p0; //msg 0
    slave_tx_dat[1]=p1; //msg 1
    slave_tx_dat[2]=p2; //msg 2
    slave_tx_dat[3]=0; //datalen
    slave_tx_dat[4]=0; //255 when message is received
    slave_tx_dat[5]=0; //255 if error has occurred
    slave_tx_dat[6]=0; //address of the Slave which sent the message
}