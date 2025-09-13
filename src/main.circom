pragma circom 2.2.2;

include "Sha256.circom";

template Sha256Main() {

    signal input ARR[1024];
    signal input LEN;

    signal output digest[8];

    component sha = Sha256();

    for (var i = 0; i < 1024; i++){
        sha.ARR[i] <== ARR[i];

    }
    sha.LEN <== LEN;

    for (var i = 0; i < 8; i++){
        digest[i] <== sha.hash[i];

        var word = sha.hash[i];
        log(word);
    }
}
component main = Sha256Main();