pragma circom 2.2.2;

template NOT(){
    signal input in;
    signal output out;

    out <== 1 - in;
}

template AND(){
    signal input a;
    signal input b;
    signal output out;
    out <== a * b;
}

template Or(){
    signal input a;
    signal input b;
    signal output out;
    signal ab;
    ab <== a * b;
    out <== a + b - ab;

}

template Xor()
{
    signal input a;
    signal input b;
    signal output out;
    signal ab;
    ab <== a * b;
    out <== a + b - 2 * ab;
}

template Mux2() {
    signal input sel;   
    signal input a;
    signal input b;
    signal output out;

    signal sel_b;
    signal not_sel;
    signal not_sel_a;

    sel * (sel - 1) === 0;       
    not_sel <== 1 - sel;

    sel_b <== sel * b;
    not_sel_a <== not_sel * a;

    out <== sel_b + not_sel_a;
}


template Num2Bits(n){
    signal input in;
    signal output bits[n];

    var i;

    for (i=0; i < n; i++){
        bits[i] <-- (in >> i) & 1;
        bits[i] * (1 - bits[i]) === 0;
    }

    var base = 1;
    var sum_val = 0;
    

    for (i = 0; i < n; i++){
        sum_val += bits[i] * base;
        base *=2;
    }
    signal sum;
    sum <== sum_val;
    sum === in;
}

template Bits2Num(n){
    signal input in[n];
    signal output out;

    var base = 1;
    var sum_val = 0;

    for (var i = 0; i < n; i++){
        sum_val += in[i] * base;
        base *=2;
    }
    out <== sum_val;

    
}

template BoundedInputN(n){
    signal input in;
    signal output out;
    component bits = Num2Bits(n);
    bits.in <== in;
    out <== bits.in;
}

template IsEqual(){
    signal input in[2];
    signal output out;

    signal diff;
    signal inv;

    diff <== in[0] - in[1];
    inv <-- diff !=0 ? 1/diff : 0;
    out <== 1 - diff * inv;
}

template Multiplier(){
    signal input a;
    signal input b;
    signal output out;

    out <== a * b;
}

template Sum32()
{
    signal input in[32];
    signal output out;

    var i;
    signal acc[32];

    acc[0] <== in[0];

    for ( i = 1 ; i < 32 ; i++){
        acc[i] <== acc[i - 1] + in[i];
    }

    out <== acc[31];
}

template Shr32(){
    signal input x[32];
    signal input j;
    signal output y[32];

    component selectors[32][32];
    component products[32][32];
    component sums[32];

    for (var i = 0; i < 32; i++) {
        for (var k = 0; k < 32; k++) {
            selectors[i][k] = IsEqual();
            selectors[i][k].in[0] <== j;
            selectors[i][k].in[1] <== k;

            products[i][k] = Multiplier();
            if (i + k < 32) {
                products[i][k].a <== selectors[i][k].out;
                products[i][k].b <== x[i + k];
            } else {
                products[i][k].a <== 0;
                products[i][k].b <== 0;
            }
        }

        sums[i] = Sum32();
        for (var k = 0; k < 32; k++) {
            sums[i].in[k] <== products[i][k].out;
        }

        y[i] <== sums[i].out;
    }
}


template RotR32(){
    signal input x[32];
    signal input j;
    signal output y[32];

    component selectors[32][32];
    component products[32][32];
    component sums[32];

    for ( var i = 0 ; i < 32; i ++)
    {
        for ( var k = 0; k < 32 ; k++){
            selectors[i][k] = IsEqual();
            selectors[i][k].in[0] <== j;
            selectors[i][k].in[1] <== (k + 32 - i) % 32;

            products[i][k] = Multiplier();
            products[i][k].a <== selectors[i][k].out;
            products[i][k].b <== x[k];
        }

        sums[i] = Sum32();
        for ( var k = 0 ; k < 32; k++){
            sums[i].in[k] <== products[i][k].out;
        }

        y[i] <== sums[i].out;
    }
}

















