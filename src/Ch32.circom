pragma circom 2.2.2;

include "BitsOps.circom"; 

template Ch32() {
    signal input e[32];
    signal input f[32];
    signal input g[32];
    signal output out[32];

    component e_and_f[32];
    component not_e[32];
    component not_e_and_g[32];
    component xor_parts[32];

    for (var i = 0; i < 32; i++) {
        e_and_f[i] = AND();
        e_and_f[i].a <== e[i];
        e_and_f[i].b <== f[i];

        not_e[i] = NOT();
        not_e[i].in <== e[i];

        not_e_and_g[i] = AND();
        not_e_and_g[i].a <== not_e[i].out;
        not_e_and_g[i].b <== g[i];

        xor_parts[i] = Xor();
        xor_parts[i].a <== e_and_f[i].out;
        xor_parts[i].b <== not_e_and_g[i].out;

        out[i] <== xor_parts[i].out;
    }
}
