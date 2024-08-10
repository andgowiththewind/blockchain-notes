// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Variables {
//状态变量存储在区块链上。
    string public text = "Hello World!";
    unit256 public num = 123;

    constructor(){
    }

    function doSomething() public {
// 局部变量不会保存到区块链上。
        unit256 i = 456;
        text = "Solidity is fun!";
        num = 456;
        uint256 timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller
    }

}
