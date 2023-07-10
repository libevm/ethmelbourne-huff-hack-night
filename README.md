# Ethmelbourne Huff Hack Night
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

# Special bounty prize
Add in support to store arrays and mappings into `SimpleStorage.huff` to win a 0.05 ETH bounty! (Limited to 1 person)

```solidity
interface ISimpleStorage {
    function setArray(uint256[] memory) external;
    function getArray(uint256 i) external returns (uint256);

    function setMap(bytes32 key, bytes32 value) external;
    function getMap(bytes32 key) external returns (bytes32);
}
```

# Notes

Test the **runtime bytecode** in [evm.codes](evm.codes)

To get the runtime bytecode:

```bash
huffc src/myHuffCode.huff -b
```