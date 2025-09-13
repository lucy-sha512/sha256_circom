pragma circom 2.2.2;

template HConstants(idx) {
    signal output out[32];

    var h = 0;

    if      (idx == 0) h = 0x6a09e667;
    else if (idx == 1) h = 0xbb67ae85;
    else if (idx == 2) h = 0x3c6ef372;
    else if (idx == 3) h = 0xa54ff53a;
    else if (idx == 4) h = 0x510e527f;
    else if (idx == 5) h = 0x9b05688c;
    else if (idx == 6) h = 0x1f83d9ab;
    else if (idx == 7) h = 0x5be0cd19;

    for (var i = 0; i < 32; i++) {
        out[i] <== (h >> i) & 1;
    }
}
