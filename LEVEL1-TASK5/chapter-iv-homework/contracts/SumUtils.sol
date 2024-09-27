// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract SumUtils {
    constructor() {}

    function sum(uint[] calldata arr) public pure returns (uint total) {
        for (uint256 i = 0; i < arr.length; i++) {
            total += arr[i];
        }
        return total;
    }
}
