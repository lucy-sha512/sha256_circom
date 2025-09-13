pragma circom 2.2.2;

include "BitsOps.circom";

template Sigma0() {
    signal input x[32];       
    signal output out[32]; 

    component r2 = RotR32();
    component r13 = RotR32();
    component  r22 = RotR32();

    for (var i = 0 ; i < 32; i ++){
        r2.x[i] <== x[i];
        r13.x[i] <== x[i];
        r22.x[i] <== x[i];
    }

    r2.j <== 2;
    r13.j <== 13;
    r22.j <== 22;

    component xor1[32];
    component xor2[32];

    for ( var i = 0 ; i < 32; i ++){
        xor1[i] = Xor();
        xor1[i].a <== r2.y[i];
        xor1[i].b <== r13.y[i];

        xor2[i] = Xor();
        xor2[i].a <== xor1[i].out;
        xor2[i].b <== r22.y[i];

        out[i] <== xor2[i].out;
    }

}
