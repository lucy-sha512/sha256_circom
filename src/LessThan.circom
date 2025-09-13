pragma circom 2.2.2;

include "BitsOps.circom";

template LessThan(n) {
    signal input in;
    signal input bound;
    signal output out;

    component inBits = Num2Bits(n);
    inBits.in <== in;

    component boundBits = Num2Bits(n);
    boundBits.in <== bound;

    signal less[n];
    signal equal[n];

    for (var i = 0; i< n; i++){
        less[i] <== (1 - inBits.bits[i]) * boundBits.bits[i];
        equal[i] <== 1 - inBits.bits[i] - boundBits.bits[i] + 2 * inBits.bits[i] * boundBits.bits[i];

    }

    signal is_equal[n + 1];
    signal is_less[n + 1];

    is_equal[n] <== 1;
    is_less[n] <== 0;

    for (var i = n-1; i >=0; i--){
        is_less[i] <== is_equal[i + 1] * less[i] + is_less[i + 1];
        is_equal[i] <== is_equal[i + 1] * equal[i];
    }

    out <== is_less[0];
    
}