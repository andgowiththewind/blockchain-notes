// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//这是一个简单的合同，你可以获取、增加和减少存储在合同中的计数。
contract Counter {
    uint256 public count;

    //获取当前计数的函数
    function get() public view returns (uint256) {
        return count;
    }

    // 将计数增加1的函数
    function inc() public {
        count += 1;
    }

    // 减1
    function dec() pub {
        count -= 1;
    }
}
