// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
在 Solidity 中，合约可以继承其他合约的功能。继承的合约（基合约）可以有带参数的构造函数。

子合约（派生合约）可以通过不同的方式初始化基合约。具体包括：
- 在继承列表中直接传递构造函数参数
- 在子合约的构造函数中传递构造函数参数
*/

contract X {
    string public name; // 公共状态变量，用于存储名称

    // 基合约 X 的构造函数
    constructor(string memory _name) {
        name = _name; // 初始化 name 变量
    }
}

contract Y {
    string public text; // 公共状态变量，用于存储文本

    // 基合约 Y 的构造函数
    constructor(string memory _text) {
        text = _text; // 初始化 text 变量
    }
}

// 合约 B 继承自 X 和 Y。
// 在继承列表中直接传递构造函数参数
// 这会初始化 X 和 Y 合约的状态变量
contract B is X("Input to X"), Y("Input to Y") {}

// 合约 C 继承自 X 和 Y。
// 在子合约的构造函数中传递构造函数参数
// 这会调用 X 和 Y 的构造函数，并将传递的参数传递给它们
contract C is X, Y {
    // 子合约的构造函数
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// 合约 D 继承自 X 和 Y。
// 在构造函数中按照继承顺序传递参数：先 X 后 Y
// 合约的基合约构造函数调用顺序如下：
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    // 子合约的构造函数
    constructor() X("X was called") Y("Y was called") {}
}

// 合约 E 继承自 X 和 Y。
// 在构造函数中按不同顺序传递参数：先 Y 后 X
// 合约的基合约构造函数调用顺序如下：
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    // 子合约的构造函数
    constructor() Y("Y was called") X("X was called") {}
}
