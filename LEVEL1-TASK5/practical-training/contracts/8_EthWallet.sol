// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
//这一个实战主要是加深大家对 3 个取钱方法的使用。
//
//- 任何人都可以发送金额到合约
//- 只有 owner 可以取款
//- 3 种取钱方式
 */
contract EthWallet {
    // 记录合约创建者
    address payable public immutable owner;

    // 日志
    event LogDeposit(string funName, address from, uint256 value, bytes data);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        // "msg.data" cannot be used inside of "receive" function.(7139)
        emit LogDeposit("receive", msg.sender, msg.value, "");
    }

    function getBalance() external view returns (uint256) {
        // this指代当前合约地址
        return address(this).balance;
    }

    //  对比之后：
    //

    function withdraw1() external {
        require(msg.sender == owner, "only owner can withdraw");
        payable(msg.sender).transfer(100);
    }

    function withdraw2() external {
        require(msg.sender == owner, "only owner can withdraw");
        bool success = payable(msg.sender).send(100);
        require(success, "transfer failed");
    }

    /**
revert
	The transaction has been reverted to the initial state.
        Note: The called function should be payable if you send value and the value you send should be less than your current balance.
You may want to cautiously increase the gas limit if the transaction went out of gas.
 */
    function withdraw3() external {
        require(msg.sender == owner, "only owner can withdraw");
        (bool success, ) = payable(msg.sender).call{value: 10}("");
        require(success, "transfer failed");
    }
}
