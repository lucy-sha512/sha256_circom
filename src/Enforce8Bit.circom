pragma circom 2.2.2;


template Enforce8Bit() {
    signal input in;
    signal output out;

    signal bits[8];
    var i;

    for (i = 0; i < 8; i++) {
        bits[i] <-- (in >> i) & 1;
        bits[i] * (1 - bits[i]) === 0;
    }

    var base = 1;
    var sum = 0;

    for (i = 0; i < 8; i++) {
        sum += base * bits[i];
        base *= 2;
    }

    out <== sum;
    out === in;
}

