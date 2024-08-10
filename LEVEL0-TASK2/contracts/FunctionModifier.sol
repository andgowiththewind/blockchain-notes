// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
修饰符（Modifiers）是可以在函数调用之前和/或之后运行的代码块。它们用于在函数执行时添加额外的逻辑或限制。

修饰符的常见用途包括：
- 限制访问权限（例如，确保只有合约拥有者才能调用某些函数）
- 验证输入参数的有效性（例如，确保传入的地址不是零地址）
- 防范重入攻击（例如，在函数执行期间锁定状态以防止重入）
*/

contract FunctionModifier {
    // 状态变量
    address public owner; // 合约拥有者地址
    uint256 public x = 10; // 一个示例变量，初始值为 10
    bool public locked; // 用于防范重入攻击的锁标志

    // 构造函数
    constructor() {
        // 将合约的拥有者设置为合约的部署者
        owner = msg.sender;
    }

    // 修饰符：检查调用者是否为合约的拥有者
    modifier onlyOwner() {
        // 确保只有合约的拥有者才能调用被修饰的函数
        require(msg.sender == owner, "Not owner");
        // `_` 是一个特殊字符，用于在修饰符中指定继续执行的代码位置
        // 它将被替换为被修饰函数的主体
        _;
    }

    // 修饰符：检查传入的地址是否为有效地址（非零地址）
    modifier validAddress(address _addr) {
        // 确保地址不为空
        require(_addr != address(0), "Not valid address");
        // `_` 继续执行修饰符之后的代码
        _;
    }

    // 函数：修改合约拥有者
    function changeOwner(address _newOwner)
    public
    onlyOwner // 应用 `onlyOwner` 修饰符，确保调用者是拥有者
    validAddress(_newOwner) // 应用 `validAddress` 修饰符，确保新地址有效
    {
        // 修改合约拥有者地址
        owner = _newOwner;
    }

    // 修饰符：防范重入攻击
    modifier noReentrancy() {
        // 确保合约在执行时没有被重入
        require(!locked, "No reentrancy");

        // 设置锁标志，标记函数正在执行
        locked = true;
        // `_` 表示被修饰函数的主体将在这里执行
        _;
        // 函数执行完毕后，重置锁标志
        locked = false;
    }

    // 函数：递减 `x` 的值，并递归调用自己
    function decrement(uint256 i) public noReentrancy {
        // 从状态变量 `x` 中减去 `i`
        x -= i;

        // 如果 `i` 大于 1，递归调用 `decrement` 函数
        if (i > 1) {
            decrement(i - 1);
        }
    }
}
