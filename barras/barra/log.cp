#line 1 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/log.c"
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
#line 3 "D:/VICENTE/Downloads/PC/ALGORITMOS_CODIGOS/GIT_GITHUB/BARRAS/barras/barra/log.c"
void logA_append(unsigned short num){


 logA[logAindex]=num;
 logAindex++;


 if(logAindex > 99)
 {
 logAindex = 0;
 }
}

void logA_reset(){
 short jj;
 for(jj=0; jj<logAindex;jj++){
 logA[jj]=0;
 }
 logAindex=0;
 Apm=-1; Apn=-1; Apx=-1; Apy=-1;
}

void logA_dir(){
 short ii=0, aux1 = 0, aux2=0;
 for(ii=0; ii<logAindex;ii++){
 if(logA[ii]==4 && aux1==0){
 Apy=ii;
 aux1=1;
 }
 if(logA[ii]==2 && aux2==0){
 Apn=ii;
 aux2=1;
 }
 }
 aux1=0;
 aux2=0;
 for(ii=1;ii<=logAindex;ii++){
 if(logA[logAindex-ii]==1 && aux1==0){
 Apm=logAindex-ii;
 aux1=1;
 }
 if(logA[logAindex-ii]==3 && aux2==0){
 Apx=logAindex-ii;
 aux2=1;
 }
 }
}

void logB_append(unsigned short num){


 logB[logBindex]=num;
 logBindex++;


 if(logBindex > 99)
 {
 logBindex = 0;
 }
}

void logB_reset(){
 short jj;
 for(jj=0; jj<logBindex;jj++){
 logB[jj]=0;
 }
 logBindex=0;
 Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
}

void logB_dir(){
 short ii=0, aux1 = 0, aux2=0;
 for(ii=0; ii<logBindex;ii++){
 if(logB[ii]==4 && aux1==0){
 Bpy=ii;
 aux1=1;
 }
 if(logB[ii]==2 && aux2==0){
 Bpn=ii;
 aux2=1;
 }
 }
 aux1=0;
 aux2=0;
 for(ii=1;ii<=logBindex;ii++){
 if(logB[logBindex-ii]==1 && aux1==0){
 Bpm=logBindex-ii;
 aux1=1;
 }
 if(logB[logBindex-ii]==3 && aux2==0){
 Bpx=logBindex-ii;
 aux2=1;
 }
 }
}
