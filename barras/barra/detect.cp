#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/detect.c"
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
#line 3 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/detect.c"
void detect(void){

 unsigned short int j1 = 0;
 unsigned short int j2 = 0;
 unsigned short int j3 = 0;

 if (PORTD.B7)
 {
#line 24 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/detect.c"
 }

 if(! PORTE.RE2 )
 {
#line 31 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/detect.c"
 }



 if( PORTB.RB6 ){
 if(ee>0){

 if(Apy == -1){
 Apy=iyn;
 iyn++;
 }
 ee=0;
 SUart0_Write('A');
 SUart0_Write('Y');
 }
 }
 else{
 if(ee==0){

 Apx = ixm;
 ixm++;


 if(ixm >= 4294967000)
 {
 if(Apx > Apm)
 {
 Apx = 1;
 Apm = 0;
 }
 else
 {
 Apx = 0;
 Apm = 1;
 }
 ixm = 2;
 }

 ee = 1;
 SUart0_Write('A');
 SUart0_Write('X');
 }
 }

 if( PORTB.RB7 ){
 if(dd>0){

 if(Apn == -1){
 Apn = iyn;
 iyn++;
 }
 dd=0;
 SUart0_Write('A');
 SUart0_Write('N');
 }
 }
 else{
 if(dd==0){

 Apm = ixm * sumi;
 ixm++;


 if(ixm >= 4294967000)
 {
 if(Apx > Apm)
 {
 Apx = 1;
 Apm = 0;
 }
 else
 {
 Apx = 0;
 Apm = 1;
 }
 ixm = 2;
 }
 dd = 1;
 SUart0_Write('A');
 SUart0_Write('M');
 }
 }

 if( PORTE.RE1 ){
 if(cc>0){

 if(Bpy == -1){
 Bpy=jyn;
 jyn++;
 }
 cc=0;
 SUart0_Write('B');
 SUart0_Write('Y');
 }
 }
 else{
 if(cc==0){

 Bpx = jxm;
 jxm++;


 if(jxm > 4294967000)
 {
 if(Bpx > Bpm)
 {
 Bpx = 1;
 Bpm = 0;
 }
 else
 {
 Bpx = 0;
 Bpm = 1;
 }
 jxm = 2;

 }
 cc = 1;
 SUart0_Write('B');
 SUart0_Write('X');
 }
 }

 if( PORTA.RA3 ){
 if(bb>0){

 if(Bpn == -1){
 Bpn = jyn;
 jyn++;
 }
 bb=0;
 SUart0_Write('B');
 SUart0_Write('N');
 }
 }
 else{
 if(bb==0){

 Bpm = jxm * sumj;
 jxm++;


 if(jxm > 4294967000)
 {
 if(Bpx > Bpm)
 {
 Bpx = 1;
 Bpm = 0;
 }
 else
 {
 Bpx = 0;
 Bpm = 1;
 }
 jxm = 2;
 }

 bb = 1;
 SUart0_Write('B');
 SUart0_Write('M');
 }
 }

 if( PORTA.RA4 ){
 if(aa>0){
 logC++;
 aa=0;
 SUart0_Write('C');
 }
 }
 else{
 if(aa==0){
 logC++;
 aa = 1;
 SUart0_Write('C');
 }
 }


 if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){
  PORTE.RE0 =0;
  PORTC.RC5 =0;
  PORTA.RA5 =1;
 }
 else{
  PORTE.RE0 =1;
  PORTC.RC5 =1;
  PORTA.RA5 =0;
 }

 if( PORTD.RD3 ){ j1 = 100;}else{ j1 = 0; }

 if( PORTC.RC4 ){ j2 = 10; }else{ j2 = 0; }

 if( PORTD.RD4 ){ j3 = 1; }else{ j3 = 0; }

 pos = j1 + j2 + j3;
}
