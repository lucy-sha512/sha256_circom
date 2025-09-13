pragma circom 2.0.0;

template KConstants(idx) {
    signal output out[32];

    var k = 0;

    if      (idx == 0)  k = 0x428a2f98;
    else if (idx == 1)  k = 0x71374491;
    else if (idx == 2)  k = 0xb5c0fbcf;
    else if (idx == 3)  k = 0xe9b5dba5;
    else if (idx == 4)  k = 0x3956c25b;
    else if (idx == 5)  k = 0x59f111f1;
    else if (idx == 6)  k = 0x923f82a4;
    else if (idx == 7)  k = 0xab1c5ed5;
    else if (idx == 8)  k = 0xd807aa98;
    else if (idx == 9)  k = 0x12835b01;
    else if (idx == 10) k = 0x243185be;
    else if (idx == 11) k = 0x550c7dc3;
    else if (idx == 12) k = 0x72be5d74;
    else if (idx == 13) k = 0x80deb1fe;
    else if (idx == 14) k = 0x9bdc06a7;
    else if (idx == 15) k = 0xc19bf174;
    else if (idx == 16) k = 0xe49b69c1;
    else if (idx == 17) k = 0xefbe4786;
    else if (idx == 18) k = 0x0fc19dc6;
    else if (idx == 19) k = 0x240ca1cc;
    else if (idx == 20) k = 0x2de92c6f;
    else if (idx == 21) k = 0x4a7484aa;
    else if (idx == 22) k = 0x5cb0a9dc;
    else if (idx == 23) k = 0x76f988da;
    else if (idx == 24) k = 0x983e5152;
    else if (idx == 25) k = 0xa831c66d;
    else if (idx == 26) k = 0xb00327c8;
    else if (idx == 27) k = 0xbf597fc7;
    else if (idx == 28) k = 0xc6e00bf3;
    else if (idx == 29) k = 0xd5a79147;
    else if (idx == 30) k = 0x06ca6351;
    else if (idx == 31) k = 0x14292967;
    else if (idx == 32) k = 0x27b70a85;
    else if (idx == 33) k = 0x2e1b2138;
    else if (idx == 34) k = 0x4d2c6dfc;
    else if (idx == 35) k = 0x53380d13;
    else if (idx == 36) k = 0x650a7354;
    else if (idx == 37) k = 0x766a0abb;
    else if (idx == 38) k = 0x81c2c92e;
    else if (idx == 39) k = 0x92722c85;
    else if (idx == 40) k = 0xa2bfe8a1;
    else if (idx == 41) k = 0xa81a664b;
    else if (idx == 42) k = 0xc24b8b70;
    else if (idx == 43) k = 0xc76c51a3;
    else if (idx == 44) k = 0xd192e819;
    else if (idx == 45) k = 0xd6990624;
    else if (idx == 46) k = 0xf40e3585;
    else if (idx == 47) k = 0x106aa070;
    else if (idx == 48) k = 0x19a4c116;
    else if (idx == 49) k = 0x1e376c08;
    else if (idx == 50) k = 0x2748774c;
    else if (idx == 51) k = 0x34b0bcb5;
    else if (idx == 52) k = 0x391c0cb3;
    else if (idx == 53) k = 0x4ed8aa4a;
    else if (idx == 54) k = 0x5b9cca4f;
    else if (idx == 55) k = 0x682e6ff3;
    else if (idx == 56) k = 0x748f82ee;
    else if (idx == 57) k = 0x78a5636f;
    else if (idx == 58) k = 0x84c87814;
    else if (idx == 59) k = 0x8cc70208;
    else if (idx == 60) k = 0x90befffa;
    else if (idx == 61) k = 0xa4506ceb;
    else if (idx == 62) k = 0xbef9a3f7;
    else if (idx == 63) k = 0xc67178f2;

    // Convert the integer to binary
    for (var i = 0; i < 32; i++) {
        out[i] <-- (k >> i) & 1;
    }
}
