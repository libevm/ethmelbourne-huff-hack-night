// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HuffDeployer.sol";

using { compile } for Vm;
using { create } for bytes;

interface ISimpleStorage {
    function increment() external;
    function setValue(uint256) external;
    function getValue() external returns (uint256);
}

contract SimpleStorageTest is Test {
    ISimpleStorage simpleStorage;

    function setUp() public {
        simpleStorage = ISimpleStorage(vm.compile("src/SimpleStorage.huff").create(0));
    }

    function testSimpleStorage_setValue(uint256 x) public {
        simpleStorage.setValue(x);
    }

    function testSimpleStorage_getValue() public {
        simpleStorage.getValue();
    }

    function testSimpleStorage_increment() public {
        simpleStorage.increment();
    }

    function testSimpleStorage_e2e() public {
        assertEq(simpleStorage.getValue(), 0);
        simpleStorage.setValue(5);
        assertEq(simpleStorage.getValue(), 5);
        simpleStorage.setValue(3);
        assertEq(simpleStorage.getValue(), 3);
        simpleStorage.increment();
        assertEq(simpleStorage.getValue(), 4);
    }
}