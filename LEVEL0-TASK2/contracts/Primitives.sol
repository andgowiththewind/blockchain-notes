// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// 在这里，我们介绍一些 Solidity 中可用的基本数据类型。
contract Primitives {
    bool public boo = true; // 布尔类型

    // `uint` 代表无符号整数，意味着非负整数。
    uint8 public u8 = 1; // 无符号 8 位整数
    uint256 public u256 = 456; // 无符号 256 位整数
    uint256 public u = 123; // 无符号整数，默认为 uint256
    // `int` 类型允许负数。
    int8 public i8 = - 1; // 有符号 8 位整数
    int256 public i256 = 456; // 有符号 256 位整数
    int256 public i = - 123; // 有符号整数，默认为 int256
    // 最大最小值
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c; // 地址类型

    /*在 Solidity 中，`byte` 数据类型表示字节序列。Solidity 提供两种字节类型：
    - 固定大小的字节数组
    - 动态大小的字节数组
    术语 `bytes` 在 Solidity 中表示动态字节数组，它是 `byte[]` 的简写。*/
    bytes1 a = 0xb5;// 1 字节
    bytes2 b = 0x56;// 2 字节

    // 未赋值的变量具有默认值。
    bool public defaultBoo; // 默认为 false
    uint256 public defaultUint; // 默认为 0
    int256 public defaultInt; // 默认为 0
    address public defaultAddr; // 默认为 0x0000000000000000000000000000000000000000
}
