pragma circom 2.2.2;

include "BitsOps.circom";

template Maj32() {
    signal input x[32];
    signal input y[32];
    signal input z[32];
    signal output out[32];

    component and_xy[32];
    component and_xz[32];
    component and_yz[32];

    component xor_temp[32];
    component xor_final[32];

    for (var i = 0; i < 32; i++) {
        and_xy[i] = AND();
        and_xz[i] = AND();
        and_yz[i] = AND();

        and_xy[i].a <== x[i];
        and_xy[i].b <== y[i];

        and_xz[i].a <== x[i];
        and_xz[i].b <== z[i];

        and_yz[i].a <== y[i];
        and_yz[i].b <== z[i];

        xor_temp[i] = Xor();
        xor_temp[i].a <== and_xy[i].out;
        xor_temp[i].b <== and_xz[i].out;

        xor_final[i] = Xor();
        xor_final[i].a <== xor_temp[i].out;
        xor_final[i].b <== and_yz[i].out;

        out[i] <== xor_final[i].out;
    }
}
