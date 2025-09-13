pragma circom 2.2.2;

include "BitsOps.circom";
include "sigma0.circom";
include "sigma1.circom";
include "Add32.circom";

template MessageSchedule(){
    signal input input_bytes[64];
    signal output w[64][32];

    component byte_bits[64];
    for (var i = 0; i < 64; i++){
        byte_bits[i] = Num2Bits(8);
        byte_bits[i].in <== input_bytes[i];
    }

    for (var t = 0; t < 16; t++){
        for (var i = 0; i < 8; i++){
            w[t][i] <== byte_bits[4 * t].bits[i];
            w[t][8 + i] <== byte_bits[ 4 * t + 1].bits[i];
            w[t][16 + i] <== byte_bits[4 * t + 2].bits[i];
            w[t][24 + i ] <== byte_bits[4 * t + 3].bits[i]; 
        }
    }

    component sig0[48];
    component sig1[48];
    component add1[48];
    component add2[48];
    component add3[48];

    for (var t = 16; t < 64; t++){
        var idx = t - 16;

        sig0[idx] = sigma0();
        sig1[idx] = sigma1();
        add1[idx] = Add32();
        add2[idx] = Add32();
        add3[idx] = Add32();

        for ( var i = 0; i < 32; i++)
        {
            sig1[idx].x[i] <== w[t-2][i];
            sig0[idx].x[i] <== w[t - 15][i];
        }

        for (var i = 0; i < 32; i++){
            add1[idx].a[i] <== sig1[idx].out[i];
            add1[idx].b[i] <== w[t-7][i];
        }

        for (var i = 0; i < 32; i++){

            add2[idx].a[i] <== add1[idx].out[i];
            add2[idx].b[i] <== sig0[idx].out[i];

        }

        for (var i = 0; i < 32; i++){
            add3[idx].a[i] <== add2[idx].out[i];
            add3[idx].b[i] <== w[t - 16][i];
        }

        for (var i = 0; i < 32; i++){
            w[t][i] <== add3[idx].out[i];

        }


        }


    }

    




    

