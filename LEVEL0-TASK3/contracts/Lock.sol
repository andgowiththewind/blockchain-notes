// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// 取消注释可以使用 `console.log` 进行调试
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime; // 解锁时间的时间戳
    address payable public owner; // 合约拥有者的地址

    // 提现事件，记录提款的金额和时间
    event Withdrawal(uint amount, uint when);

    // 构造函数，初始化合约的解锁时间和拥有者
    constructor(uint _unlockTime) payable {
        // 要求解锁时间必须是未来的时间
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime; // 设置解锁时间
        owner = payable(msg.sender); // 将合约的拥有者设置为部署合约的地址
    }

    // 提现函数，允许拥有者在解锁时间之后提取全部余额
    function withdraw() public {
        // 取消注释可以在终端打印日志信息
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        // 确保当前时间已经超过或达到解锁时间
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        // 确保只有合约拥有者才能调用此函数
        require(msg.sender == owner, "You aren't the owner");

        // 触发提现事件，记录提现金额和时间
        emit Withdrawal(address(this).balance, block.timestamp);

        // 将合约中的所有余额转移给拥有者
        owner.transfer(address(this).balance);
    }
}
