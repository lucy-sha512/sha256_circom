pragma circom 2.0.0;

include "Sigma0.circom";
include "Sigma1.circom";
include "Ch32.circom";
include "Maj32.circom";
include "Add32.circom";

template Sha256Round() {
    // Input state variables (32 bits each, total 256 bits)
    signal input a[32];
    signal input b[32];
    signal input c[32];
    signal input d[32];
    signal input e[32];
    signal input f[32];
    signal input g[32];
    signal input h[32];

    // Message schedule word and constant for this round
    signal input w[32];
    signal input k[32];

    // Output state variables
    signal output a_out[32];
    signal output b_out[32];
    signal output c_out[32];
    signal output d_out[32];
    signal output e_out[32];
    signal output f_out[32];
    signal output g_out[32];
    signal output h_out[32];

    // Compute Σ1(e)
    component sig1 = Sigma1();
    for (var i = 0; i < 32; i++) {
        sig1.x[i] <== e[i];
    }

    // Compute Σ0(a)
    component sig0 = Sigma0();
    for (var i = 0; i < 32; i++) {
        sig0.x[i] <== a[i];
    }

    // Ch(e, f, g)
    component ch = Ch32();
    for (var i = 0; i < 32; i++) {
        ch.e[i] <== e[i];
        ch.f[i] <== f[i];
        ch.g[i] <== g[i];
    }

    // Maj(a, b, c)
    component maj = Maj32();
    for (var i = 0; i < 32; i++) {
        maj.x[i] <== a[i];
        maj.y[i] <== b[i];
        maj.z[i] <== c[i];
    }

    // Compute T1 = h + Σ1(e) + Ch(e,f,g) + w + k
    component t1_add1 = Add32();  // h + Σ1(e)
    component t1_add2 = Add32();  // + Ch
    component t1_add3 = Add32();  // + w
    component t1_add4 = Add32();  // + k

    t1_add1.a <== h;
    t1_add1.b <== sig1.out;

    t1_add2.a <== t1_add1.out;
    t1_add2.b <== ch.out;

    t1_add3.a <== t1_add2.out;
    t1_add3.b <== w;

    t1_add4.a <== t1_add3.out;
    t1_add4.b <== k;

    // Compute T2 = Σ0(a) + Maj(a,b,c)
    component t2_add = Add32();
    t2_add.a <== sig0.out;
    t2_add.b <== maj.out;

    // d + T1
    component e_new = Add32();
    e_new.a <== d;
    e_new.b <== t1_add4.out;

    // T1 + T2
    component a_new = Add32();
    a_new.a <== t1_add4.out;
    a_new.b <== t2_add.out;

    // Final state update
    for (var i = 0; i < 32; i++) {
        a_out[i] <== a_new.out[i];
        b_out[i] <== a[i];
        c_out[i] <== b[i];
        d_out[i] <== c[i];
        e_out[i] <== e_new.out[i];
        f_out[i] <== e[i];
        g_out[i] <== f[i];
        h_out[i] <== g[i];
    }
}

