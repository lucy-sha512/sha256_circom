# ABOUT

This repository contains a full SHA-256 implementation in Circom 2.2.2, compatible with constraint systems such as R1CS. The implementation is designed to hash binary messages of variable lengths up to 1024 bytes.

- main.circom             # Entry point: calls Sha256Main and logs hex digest
- Sha256.circom           # Top-level SHA256 wrapper circuit
- PadMessage.circom       # Pads input message according to SHA256 standard
- MessageSchedule.circom  # Expands 512-bit blocks into 64 32-bit words
- Sha256Compression.circom# Performs 64 compression rounds on the padded input
- Sha256Round.circom      # A single round of SHA256 compression function
- K_constants.circom      # Outputs 64 SHA256 round constants
- H_constants.circom      # Outputs initial SHA256 state constants
- BitOps.circom           # Utility circuits (Num2Bits, Bits2Num)
- test/                   # Folder for input/output tests

# Core Templates
## PadMessage
Input: ARR[1024]: 8-bit input bytes
LEN: length of the actual message (in bytes)
Output: padded[1024]: padded binary array (bitwise)
Function: Pads the message with 0x80, then zeroes, and finally appends a 64-bit binary representation of the original length.

## MessageSchedule
Input: input_bytes[64] (padded 512-bit block)
Output: w[64][32] (expanded message schedule)
Function: Converts the input block into 64 32-bit words using σ0, σ1, and prior values as per the SHA-256 spec.

## Sha256Round
Inputs: Eight 32-bit values: a through h
Message schedule word: w[32]
Constant: k[32]
Outputs: Updated a_out through h_out
Function: Computes one round of the SHA-256 compression using Σ0, Σ1, Maj, and Ch operations.

## Sha256Compression
Inputs: Initial state: H[8][32]
Message schedule: W[64][32]
Output: H_new[8][32]: Final hash state
Function: Performs 64 compression rounds and adds results to the initial state.

## Sha256
Inputs: ARR[1024]: input bytes (each 8-bit)
LEN: actual length of the message
Output:
hash[256]: SHA-256 hash output as 256 bits Function: Wraps padding, message schedule, and compression into one unified circuit.


# Run
## Compile the circuit
```
circom main.circom --r1cs --wasm --sym
```
## Generate witness to JSON
```
node main_js/generate_witness.js main_js/main.wasm input.json witness.wtns
```
## Export to witness.json
```
snarkjs wtns export json witness.wtns witness.json

```
## Output Extraction

```
python3 extract_sha256_digest.py
```
