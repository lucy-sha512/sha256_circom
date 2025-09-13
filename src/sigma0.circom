pragma circom 2.2.2;

include "BitsOps.circom";

template sigma0() {
    signal input x[32];       
    signal output out[32]; 

    component r7 = RotR32();
    component r18 = RotR32();
    component  s3 = Shr32();

    for ( var i = 0 ; i < 32; i ++){
        r7.x[i] <== x[i];
        r18.x[i] <== x[i];
        s3.x[i] <== x[i];
    }
    r7.j <== 7;
    r18.j <== 18;
    s3.j <== 3;

    component xor1[32];
    component xor2[32];

    for ( var i = 0 ; i < 32; i++ ){
        xor1[i] = Xor();
        xor1[i].a <== r7.y[i];
        xor1[i].b <== r18.y[i];

        xor2[i] = Xor();
        xor2[i].a <== xor1[i].out;
        xor2[i].b <== s3.y[i];

        out[i] <== xor2[i].out;
    }

}
