pragma circom 2.2.2;

include "PadMessage.circom";
include "MessageSchedule.circom";
include "Sha256Compression.circom";
include "H_constants.circom";
include "BitsOps.circom";

template Sha256(){
    signal input ARR[1024];
    signal input LEN;
    signal output hash[8];

    component pad = PadMessage();
    for (var i = 0; i < 1024; i++){
        pad.ARR[i] <== ARR[i];
    }
    pad.LEN <== LEN;

    signal block[64];
    for (var i = 0; i < 64; i++){
        block[i] <== pad.padded[i];
    }

    component schedule = MessageSchedule();
    for (var i = 0; i < 64; i++){
        schedule.input_bytes[i] <== block[i];
    }

    signal H[8][32];
    component H_inits[8];
    for (var i = 0; i < 8; i++){
        H_inits[i] = HConstants(i);
        for (var j = 0; j < 32; j++){
            H[i][j] <== H_inits[i].out[j];
        }
    }

    component compression = Sha256Compression();
    for (var i = 0; i < 8; i++){
        for (var j = 0; j < 32; j++){
            compression.H[i][j] <== H[i][j];
        }
    }
    for (var t = 0; t < 64; t++){
        for (var j = 0; j < 32; j++){
            compression.W[t][j] <== schedule.w[t][j];
        }
    }

    

    component toNum[8];
    for(var i = 0; i < 8; i++){
        toNum[i] = Bits2Num(32);
        for (var j = 0; j < 32; j++){
            toNum[i].in[j] <== compression.H_new[i][j];
        }
        hash[i] <== toNum[i].out;
    }

    
}
