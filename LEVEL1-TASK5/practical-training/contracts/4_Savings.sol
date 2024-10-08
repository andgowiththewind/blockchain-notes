// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;
/*
(1)---所有人都可以存钱 ETH
(2)---只有合约 owner 才可以取钱
(3)---只要取钱，合约就销毁掉 selfdestruct
(4)---扩展：支持主币以外的资产 ERC20     ERC721
*/
contract Savings {
    address public immutable owner;

    // 构造函数
    constructor() {
        // msg.sender 是部署合约的人
        owner = msg.sender;
    }

    // 事件:日志
    // indexed的作用是为了让这个字段可以被搜索
    // amount 是存入的金额
    event Deposit(address indexed _from, uint _amount);
    // 提钱
    event Withdrawal(address indexed _to, uint _amount);

    // 接收资产
    // external 表示只能通过外部调用
    // payable  表示这个函数可以接收资产
    receive() external payable {
        // emit的意思是触发事件
        emit Deposit(msg.sender, msg.value);
    }

    // 取钱
    function withdraw(address payable _to, uint _amount) public {
        // 只有合约的所有者才能取钱
        require(msg.sender == owner, "You are not the owner");
        // 转账
        // transfer 是一个内置函数，用来转账,这里表示从合约转账到_to
        _to.transfer(_amount);
        // 销毁合约
        selfdestruct(_to);
        // 触发事件
        emit Withdrawal(_to, _amount);
    }

    // 查看余额
    function getBalance() external view returns (uint) {
        // address(this) 表示合约的地址
        return address(this).balance;
    }
}
