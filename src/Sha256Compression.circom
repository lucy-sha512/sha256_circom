pragma circom 2.2.2;

include "Sha256Round.circom";
include "K_constants.circom";

template Sha256Compression(){
    signal input H[8][32];
    signal input W[64][32];
    signal output H_new[8][32];

  

    signal a[65][32];
    signal b[65][32];
    signal c[65][32];
    signal d[65][32];
    signal e[65][32];
    signal f[65][32];
    signal g[65][32];
    signal h[65][32];

    for (var i = 0; i < 32; i++){
        a[0][i] <== H[0][i];
        b[0][i] <== H[1][i];
        c[0][i] <== H[2][i];
        d[0][i] <== H[3][i];
        e[0][i] <== H[4][i];
        f[0][i] <== H[5][i];
        g[0][i] <== H[6][i];
        h[0][i] <== H[7][i];
    }

    component rounds[64];
    component Kconsts[64];

    for (var t = 0; t < 64 ; t++){
        rounds[t] = Sha256Round();
        Kconsts[t] = KConstants(t);

        for (var i = 0; i < 32; i++){
            rounds[t].a[i] <== a[t][i];
            rounds[t].b[i] <== b[t][i];
            rounds[t].c[i] <== c[t][i];
            rounds[t].d[i] <== d[t][i];
            rounds[t].e[i] <== e[t][i];
            rounds[t].f[i] <== f[t][i];
            rounds[t].g[i] <== g[t][i];
            rounds[t].h[i] <== h[t][i];
            rounds[t].w[i] <== W[t][i];
            rounds[t].k[i] <== Kconsts[t].out[i];
        }

        for (var i = 0; i < 32; i++){
            a[t+1][i] <== rounds[t].a_out[i];
            b[t+1][i] <== rounds[t].b_out[i];
            c[t+1][i] <== rounds[t].c_out[i];
            d[t+1][i] <== rounds[t].d_out[i];
            e[t+1][i] <== rounds[t].e_out[i];
            f[t+1][i] <== rounds[t].f_out[i];
            g[t+1][i] <== rounds[t].g_out[i];
            h[t+1][i] <== rounds[t].h_out[i];
        }
    }

    component adders[8];
    for (var i = 0; i < 8; i++){
        adders[i] = Add32();
        for (var j = 0; j < 32; j++){
            adders[i].a[j] <== H[i][j];
        }

        if ( i == 0){
            for (var j = 0; j < 32; j++) adders[i].b[j] <== a[64][j];

        } else if ( i == 1){
            for (var j = 0; j < 32 ; j++) adders[i].b[j] <== b[64][j];

        }else if ( i == 2){
            for ( var j = 0; j < 32; j++) adders[i].b[j] <== c[64][j];
        }else if ( i == 3){
            for ( var j = 0; j < 32; j++) adders[i].b[j] <== d[64][j];
        }else if (i == 4){
            for ( var j = 0; j < 32 ; j++) adders[i].b[j] <== e[64][j];
        }else if ( i == 5){
            for (var j = 0; j < 32; j++) adders[i].b[j] <== f[64][j];
        }else if ( i == 6){
            for (var j = 0; j < 32; j++) adders[i].b[j] <== g[64][j];
        }else if (i == 7){
            for (var j = 0; j < 32 ; j++) adders[i].b[j] <== h[64][j];
        }

        for (var j = 0; j < 32; j++){
            H_new[i][j] <== adders[i].out[j];
        }
    }


    

    

}
