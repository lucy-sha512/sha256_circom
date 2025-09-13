pragma circom 2.2.2;

include "BitsOps.circom";

template Add32() {
    signal input a[32];
    signal input b[32];
    signal output out[32];

    signal carry[33];
    carry[0] <== 0;

    component xor1[32];
    component xor2[32];
    component and1[32];
    component and2[32];
    component and3[32];
    component or1[32];
    component or2[32];

    for (var i = 0; i < 32; i++) {
        xor1[i] = Xor();
        xor1[i].a <== a[i];
        xor1[i].b <== b[i];

        xor2[i] = Xor();
        xor2[i].a <== xor1[i].out;
        xor2[i].b <== carry[i];
        out[i] <== xor2[i].out;

        

        and1[i] = AND();
        and1[i].a <== a[i];
        and1[i].b <== b[i];

        and2[i] = AND();
        and2[i].a <== a[i];
        and2[i].b <== carry[i];

        and3[i] = AND();
        and3[i].a <== b[i];
        and3[i].b <== carry[i];

        or1[i] = Or();
        or1[i].a <== and1[i].out;
        or1[i].b <== and2[i].out;

        or2[i] = Or();
        or2[i].a <== or1[i].out;
        or2[i].b <== and3[i].out;

        carry[i + 1] <== or2[i].out;
    }
}
