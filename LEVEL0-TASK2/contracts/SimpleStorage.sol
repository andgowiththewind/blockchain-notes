// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//要写入或更新状态变量，你需要发送一个交易。
//另一方面，你可以免费读取状态变量，无需支付任何交易费用。
contract SimpleStorage {
    unit256 public num;

    // You need to send a transaction to write to a state variable.
    function set(unint256 _num) public {
        num = _num;
    }

// You can read from a state variable without sending a transaction.
    function get() public view returns (unit256) {
        return num;
    }

}
