#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/counter.c"
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
#line 3 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/counter.c"
void counter(void){

 if(aa!=0 && bb!=0 && cc!=0 && dd!=0 && ee!=0){
 if(bk==1){
 contador_seg=0;
  PORTD.RD5  = 1;
 bk=0;
 }
 if(pp==1){

 if(logC>=2){



 if(Apm!=-1 && Apn!=-1 && Apx!=-1 && Apy!=-1){
 if(Apm>Apx){

 if(Apn>Apy){

 resultadoA='E';
 }
 else{

 resultadoA='Q';
 }
 }
 else{

 if(Apn>Apy){

 resultadoA='P';
 }
 else{

 resultadoA='S';
 }
 }
 }



 if(Bpm!=-1 && Bpn!=-1 && Bpx!=-1 && Bpy!=-1){
 if(Bpm>Bpx){

 if(Bpn>Bpy){

 resultadoB='E';
 }
 else{

 resultadoB='Q';
 }
 }
 else{

 if(Bpn>Bpy){

 resultadoB='P';
 }
 else{

 resultadoB='S';
 }
 }
 }

 if(resultadoA!='X' && resultadoB!='X'){
 if(resultadoB=='S' || (resultadoA=='S' && resultadoB=='P')){
 resultadoT='S';
 }
 if(resultadoB=='E' || (resultadoA=='E' && resultadoB=='Q')){
 resultadoT='E';
 }
 }

 if(pos==1){
 if(resultadoT=='E'){ resultadoT='X'; }
 }
 else if(pos==11){
 if(resultadoT=='S'){ resultadoT='X'; }
 }
 else if(pos==111){
 if(resultadoT=='E'){ resultadoT='S'; }
 else if(resultadoT=='S'){ resultadoT='E'; }
 }
 else if(pos==110){
 if(resultadoT=='E'){ resultadoT='S'; }
 else if(resultadoT=='S'){ resultadoT='X'; }
 }
 else if(pos==100){
 if(resultadoT=='E'){ resultadoT='X'; }
 else if(resultadoT=='S'){ resultadoT='E'; }
 }


 if(resultadoT=='E'){
 ENTRAN++;
 NUMPER=ENTRAN+SALEN;
 resultadoT='X';



 }
 if(resultadoT=='S'){
 SALEN++;
 NUMPER=ENTRAN+SALEN;
 resultadoT='X';
#line 118 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/counter.c"
 }

 }

 logC=0;
 Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
 Apm=-1; Apn=-1; Apx=-1; Apy=-1;
 iyn=0; ixm = 0; jyn=0; jxm=0;
 aa=2; bb=2; cc=2; dd=2; ee=2;
 pp=0;
 }
 }

 if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){
 if(pp==0){
 pp=1;
 resultadoA='X';
 resultadoB='X';
 resultadoT='X';
 }
 if (bk==0){ bk=1; }
 }
}
