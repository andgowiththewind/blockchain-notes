// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
映射（Maps）使用语法 `mapping(keyType => valueType)` 创建。
- `keyType` 可以是任何内置值类型、`bytes`、`string` 或任何合约。
- `valueType` 可以是任何类型，包括另一个映射或数组。
映射是不可迭代的。
*/
contract Mapping {
    // Mapping from address to uint
    mapping(address => uint256) public myMap;

    function get(address _addr) public view returns (uint256) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return myMap[_addr];
    }

    function set(address _addr, uint256 _i) public {
        // Update the value at this address
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // Reset the value to the default value.
        delete myMap[_addr];
    }
}