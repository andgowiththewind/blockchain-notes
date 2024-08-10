// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//不可变变量类似于常量。不可变变量的值可以在构造函数中设置，但之后不能再修改。
contract Immutable {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(address _address, uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
