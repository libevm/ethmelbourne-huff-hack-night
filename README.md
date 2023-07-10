# ethmelbourne-huff-hack-night
Hack Night Ethereum Melbourne with Huff!

# Steps

1. Install Forge

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

2. Install Huff

```bash
curl -L get.huff.sh | bash
huffup
```

3. Run the tests (need FFI support to work in Huff)

```bash
forge test --ffi
```