// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HuffDeployer.sol";

using {compile} for Vm;
using {create} for bytes;

interface IAddTwo {
    function addTwo(uint256, uint256) external view returns (uint256);
}

contract AddTwoTest is Test {
    IAddTwo huffAddTwo;

    function setUp() public {
        huffAddTwo = IAddTwo(vm.compile("src/AddTwo.huff").create(0));
    }

    function testAddition(uint256 x, uint256 y) public {
        if (x >= type(uint256).max / 2) return;
        if (y >= type(uint256).max / 2) return;

        assertEq(huffAddTwo.addTwo(x, y), x + y);
    }
}
