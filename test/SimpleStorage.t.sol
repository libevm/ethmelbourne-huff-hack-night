// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HuffDeployer.sol";

using { compile } for Vm;
using { create } for bytes;

interface ISimpleStorage {
    function increment() external;
    
    function getValue() external returns (uint256);
    function setValue(uint256) external;
    
    function getString() external returns (string memory);
    function setString(string memory) external;

    function getArray() external returns (uint256[] memory);
    function setArray(uint256[] memory) external;

    function getMap(bytes32 key) external returns (bytes32);
    function setMap(bytes32 key, bytes32 value) external;
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

    function testSimpleStorageString_e2e() public {
        assertEq(simpleStorage.getString(), "");
        simpleStorage.setString("Thomas");
        assertEq(simpleStorage.getString(), "Thomas");
        simpleStorage.setString("ethmelbourne");
        assertEq(simpleStorage.getString(), "ethmelbourne");
        simpleStorage.setString("working?");
        assertEq(simpleStorage.getString(), "working?");
     }

    function testSimpleStorageArray_e2e() public {
        uint256[] memory myArray = new uint256[](4);
        myArray[0] = 9;
        myArray[1] = 8;
        myArray[2] = 7;
        myArray[3] = 6;

        simpleStorage.setArray(myArray);
        assertEq(simpleStorage.getArray(), myArray);
    }

    function testSimpleStorageMap_e2e() public {
        bytes32 key = "eth";
        bytes32 value = "Melbourne";
        simpleStorage.setMap(key, value);
        assertEq(simpleStorage.getMap(key), value);

        // Update for same key
        value = "Test2";
        simpleStorage.setMap(key, value);
        assertEq(simpleStorage.getMap(key), value);

        key = "newKey";
        simpleStorage.setMap(key, value);
        assertEq(simpleStorage.getMap(key), value);
    }

}