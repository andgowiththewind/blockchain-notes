// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//常量是不能被修改的变量。
//它们的值是硬编码的，使用常量可以节省 gas 费用。
contract Constants {
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    unit256 public constant MY_UINT = 123;
}
