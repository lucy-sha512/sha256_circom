pragma circom 2.2.2;
include "BitsOps.circom";

template sigma1(){
    signal input x[32];
    signal output out[32];

    component r17 = RotR32();
    component r19 = RotR32();
    component s10 = Shr32();

    for ( var i = 0 ; i < 32; i ++)
    {
        r17.x[i] <== x[i];
        r19.x[i] <== x[i];
        s10.x[i] <== x[i];
    }

    r17.j <== 17;
    r19.j <== 19;
    s10.j <== 10;

    component xor1[32];
    component xor2[32];

    for ( var i = 0 ; i < 32 ; i++){
        xor1[i] = Xor();
        xor1[i].a <== r17.y[i];
        xor1[i].b <== r19.y[i];

        xor2[i] = Xor();
        xor2[i].a <== xor1[i].out;
        xor2[i].b <== s10.y[i];

        out[i] <== xor2[i].out;
    }
}