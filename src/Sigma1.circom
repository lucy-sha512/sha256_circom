pragma circom 2.2.2;

include "BitsOps.circom";

template Sigma1() {
    signal input x[32];       
    signal output out[32]; 

    component r6 = RotR32();
    component r11 = RotR32();
    component  r25 = RotR32();

    for (var i = 0 ; i < 32; i ++){
        r6.x[i] <== x[i];
        r11.x[i] <== x[i];
        r25.x[i] <== x[i];
    }

    r6.j <== 6;
    r11.j <== 11;
    r25.j <== 25;

    component xor1[32];
    component xor2[32];

    for ( var i = 0 ; i < 32; i ++){
        xor1[i] = Xor();
        xor1[i].a <== r6.y[i];
        xor1[i].b <== r11.y[i];

        xor2[i] = Xor();
        xor2[i].a <== xor1[i].out;
        xor2[i].b <== r25.y[i];

        out[i] <== xor2[i].out;
    }

}