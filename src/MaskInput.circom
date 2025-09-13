pragma circom 2.2.2;

include "Enforce8Bit.circom";
include "BitsOps.circom";
include "LessThan.circom";

template MaskInput() {
    signal input ARR[1024];  
    signal input LEN;        
    signal output out[1024]; 

    component enforce[1024];
    component is_less[1024];

    for (var i = 0; i < 1024; i++) {

        enforce[i] = Enforce8Bit();
        enforce[i].in <== ARR[i];

        is_less[i] = LessThan(10);
        is_less[i].in <== i;
        is_less[i].bound <== LEN;

        out[i] <== is_less[i].out * ARR[i];
    }
}