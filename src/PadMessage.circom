pragma circom 2.2.2;

include "BitsOps.circom";
include "LessThan.circom";
include "Enforce8Bit.circom";

template PadMessage(){
    signal input ARR[1024];
    signal input LEN;
    signal output padded[1024];

    component less_than[1024];
    component is_equal[1024];
    component mux[1024];
    component enforce[1024];

    component length_bits = Num2Bits(64);
    length_bits.in <== LEN; 

    for ( var i = 0; i < 1024; i++){
        less_than[i] = LessThan(11);
        less_than[i].in <== i;
        less_than[i].bound <== LEN;

        is_equal[i] = IsEqual();  
        is_equal[i].in[0] <== i;
        is_equal[i].in[1] <== LEN;

        mux[i] = Mux2();
        enforce[i] = Enforce8Bit();

        enforce[i].in <== ARR[i];
        mux[i].a <== is_equal[i].out * 128 + (1 - is_equal[i].out)*enforce[i].out;
        mux[i].b <== 0;

        mux[i].sel <== less_than[i].out + is_equal[i].out;
        
        }

        var temp_padded[1024];
        for (var i = 0; i < 1024; i++){
            temp_padded[i] = mux[i].out;
        }

        var length_appended[64];
        for (var i = 0; i < 64; i++){
            length_appended[i] = length_bits.bits[i];
        }

        component mux2[1024];

        for (var i = 0; i < 1024; i++){

            mux2[i] = Mux2();
            mux2[i].a <== ( i < 1024 - 64)? temp_padded[i]:0;
            mux2[i].b <== ( i >= 1024 - 64)? length_appended[i - (1024 - 64)]: 0;

            mux2[i].sel <== (i < 1024 - 64);

            padded[i] <== mux2[i].out;
            
        }
}
