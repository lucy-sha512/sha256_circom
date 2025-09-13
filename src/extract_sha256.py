import json

# Load witness.json
with open("witness.json", "r") as f:
    witness = json.load(f)

# SHA256 output starts after the first element ("1")
digest_words = witness[1:9]

# Convert to hex and pad to 8 characters
digest_hex = ''.join([format(int(word), '08x') for word in digest_words])

# Print results
print("SHA256 Hex Digest:")
print(digest_hex)
