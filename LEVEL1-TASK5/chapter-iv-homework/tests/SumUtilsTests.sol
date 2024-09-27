// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "contracts/SumUtils.sol";


contract SumUtilsTests {
    SumUtils sumUtils;

    constructor() {
        sumUtils = new SumUtils();
    }

    function testSum() public view returns (uint total) {
        uint[] memory arr = new uint[](3);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        total = sumUtils.sum(arr);
        return total;

    }

}