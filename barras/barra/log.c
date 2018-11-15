#include "extern.h"

void logA_append(unsigned short num){
    //if(contador_seg < 3)
    //{
     logA[logAindex]=num;
     logAindex++;
    //}
    //pc
    if(logAindex > 99)//controlar desbordamiento en el array
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

void logA_dir(){ // 1=M 2=N 3=X 4=Y
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

void logB_append(unsigned short num){ // 1=M 2=N 3=X 4=Y
    //if(contador_seg < 3)
    //{
     logB[logBindex]=num;
     logBindex++;
    //}
    //pc
    if(logBindex > 99) //contolar desbordamiento en el array
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

void logB_dir(){ // 1=M 2=N 3=X 4=Y
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