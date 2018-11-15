//SWUART_DOC.H   v3.0, © Istvan K, April 2014

The SwUart library allows you to handle 4 independent software (bit-banging) Uart.

    As the LCD libraries there are three library prefixes (p*):
      p16   for PIC 12/16 (non-enhanced) family
      p16e  for PIC 12/16 enhanced family
      p18   for PIC 18 family

    eg the "p18_SwUart-4.mcl" is working on any PIC18 chip.

-----------

   - user definable baudrate: see (and use) the "pic_SwUart_Baud.c" file,
       or
   - use a "p*_SwUart-8m9600-4.mcl" library file (fixed, predetermined baudrate):
         (fix 9600 Bd at 8MHz; 4800 Bd  at 4MHz; 19200 Bd at 16MHz)
     and do not use the "pic_SwUart_Baud.c" file


   - can be also 1-wire Uart (ie write-only, RX_pin is the same as the TX_pin)

   - normal _ReadW function (blocking: it is 'w'aiting for a char)

   - non-blocking _ReadT function (2 or 3 pins) using CTS handshake with 't'imeout

     Notes about the CTS:
       the terminal's  CTS pin is used for a hw handshake (if 0: Clear To Send)
         so no need any break via interrupt + timer
       use it only on any DCE type terminals
         (like the Virtual Terminal in Proteus, where CTS is an input pin),
         in case of a DTE type terminal use its RTS pin, instead

     Notes about the 2-pin _ReadT configuration:
       CTS and TX pins may be tied together (only two wires) but in this case
         here is a little restriction:
       the CTS state must be restored ( set to low) when the writing is completed
         because the TX pin's idle state is normally high.

----------------

    Pin definitions (for a PIC16, only an example):

  //uart0 is 2-wire (CTS = TX)
sbit Stx0_pin  at PORTA.B0; // on a PIC18 use LATx (below too)
sbit Srx0_pin  at PORTA.B1; // on a PIC18 *** do not use LATx here *** !!!!!
sbit Scts0_pin at Stx0_pin; // or choose any other pin for a separated CTS (3-wire)
sbit Stx0_pin_Direction  at TRISA.B0;
sbit Srx0_pin_Direction  at TRISA.B1;
sbit Scts0_pin_Direction at Stx0_pin_Direction;

  //uart1,2,3 are 1-wire (write-only) terminals
sbit Stx1_pin  at PORTB.B1; // on a PIC18 use LATx
sbit Srx1_pin  at Stx1_pin; //         -"-
sbit Stx1_pin_Direction  at TRISB.B1;
sbit Srx1_pin_Direction  at Stx0_pin_Direction;

sbit Stx2_pin  at PORTB.B2;
sbit Srx2_pin  at Stx2_pin;
sbit Stx2_pin_Direction  at TRISB.B2;
sbit Srx2_pin_Direction  at Stx2_pin_Direction;

sbit Stx3_pin  at PORTB.B3;
sbit Srx3_pin  at Stx3_pin;
sbit Stx3_pin_Direction  at TRISB.B3;
sbit Srx3_pin_Direction  at Stx3_pin_Direction;

----------------

   Fundamental library functions (X = 0,1,2 or 3):

SUartX_Init_W()        // for 1- or 2-wire Uart (only _ReadW is possible)
SUartX_Init_T()        // using Timeout and CTS (also non-blocking _ReadT)

   The ..Init function(s) can be omitted using the proper port settings:
     all RX pins are input and set to 1,
     all TX pins must be output and set to 1 (if TX pin = CTS pin, set to 0),
     all CTS pins must be output and set to 0

char SUartX_ReadW()  // Wait for a char (blocking read)

char SUartX_ReadT()  // Timeout and CTS is used (non-blocking)
     Note:
     there is a (rarely necessary) zero value receiving issue about
     the _ReadT since it returns with zero even if timeout is occured.
     To solve this _ReadT has an implicite (second) return value too:
     the C_bit (carry ie overflow flag) will be set (= 1) if timeout is
     occured, but cleared (= 0) after any valid (succesful) receiving.
        Usage:
          if ( ch = SUart0_ReadT(), !C_bit ) {
             // now ch can be zero also
          }

SUartX_Write(char)
     write 0x12 to clear the Virtual Terminal window
     use 7 for a bell, 8 for backspace, 0x0D for newline ...

------------- END of fundamental library functions


In addition, the SwUart library also contains a collection of routines
(named as common output functions), using the SUart0 char-out routine:
     "SUart0_Write"

The concrete function-name also uses the specific, library-dependent
prefix as the fundamental functions (see above),

 BUT:

although the SwUart lib contains four SwUart, the common function-set is included
ONLY for the first one (the "SUart0"), for the other three items (SUart1...3) only
the fundamental functions (like the ..Init) are included.

It would result too large *.MCL files (may be 110+ kByte) if the common
routines are included four times. If you have more than one SwUart terminal
then use my new "p*_Out_Univ" library (look at the file "OUT_UNIV_DOC.H").
This method results a faster and much smaller code (see the example project).

----------

There are 12 common SwUart functions, using the "SUart0_" prefix (below: ...):
For example, the real name of the "...RstrNout" is "SUart0_RstrNout".

----------

   String outputs:

...RstrOut (char* rptr)               // write out a string stored in Ram
...RstrNout(char* rptr, char N)       //  the same but max N char(s)
...CstrOut (const char* cptr)         // write out a string stored in Code memory
...CstrNout(const char* cptr, char N) //  the same but max N char(s)


   Direct conversions (without any temporary buffer):

...BcdOut (char)     //  "dd", char: max 0x99 (153), with leading zero(es)
...Dec2out(char)     //  "dd", char: max 99,                  -"-
...Hex2out(char)     //  "hh", char: max 255,                 -"-
...Hex4out(unsigned) //  "hhhh", max 65535,                   -"-

       Justified direct conversions
       (controlled by an additional "just" parameter):

       just = -1: (just.B7 = 1) no alignment, leading zeroes also printed
       just =  0: leading zeroes will be supressed: left  justified
       just =  1: leading zeroes will be a space:   right justified

...Dec2out_J(char onebyte, char just) //    "dd" (or "d" or " d"), max 99 !!
...Dec3out_J(unsigned wrd, char just) //   "ddd", max 999
...Dec4out_J(unsigned wrd, char just) //  "dddd", max 9999
...Dec5out_J(unsigned wrd, char just) // "ddddd", max 65535

---------------- End of library functions

    A simple p16 demo program:

/* Use the "p16_SwUart-4.mcl":
     add this library file to the project by right-clicking on the Binaries node
     (see help) then add also the
         "pic_SwUart_Baud.c"
     to your project by right-clicking on the Sources node
*/

  // uart0 is 3-wire (separated CTS)
sbit Stx0_pin  at PORTA.B0;
sbit Srx0_pin  at PORTA.B1;
sbit Scts0_pin at PORTA.B2;
sbit Stx0_pin_Direction  at TRISA.B0;
sbit Srx0_pin_Direction  at TRISA.B1;
sbit Scts0_pin_Direction at TRISA.B2;

  // uart1 is 1-wire (write-only)
sbit Stx1_pin  at PORTA.B3;
sbit Srx1_pin  at Stx1_pin;
sbit Stx1_pin_Direction  at TRISA.B3;
sbit Srx1_pin_Direction  at Stx1_pin_Direction;


const char cstr[] = "Uart";
char rch;

void main() {

     CMCON = 7; // 16f628a: disable comparators

     SUart0_Init_T();
     SUart1_Init_W();

     SUart0_CstrOut(cstr);
     SUart0_Write('0');

     // since no SUart1_CstrOut, out letter by letter (or use Out_Univ)
     SUart1_Write('U');
     SUart1_Write('a');
     SUart1_Write('r');
     SUart1_Write('t');
     SUart1_Write('1');

     for (;;) {
       if ( (rch = SUart0_ReadT()) ) { //non-blocking read
          SUart0_Write(' ');
          SUart0_Hex2out(rch);
          //Scts0_pin = 0; // restore CTS (if Scts0_pin is the same as Stx0_pin)
          SUart1_Write(' ');
          SUart1_Write(rch);
       }
       Delay_ms(10);
     }
}

---------------- END