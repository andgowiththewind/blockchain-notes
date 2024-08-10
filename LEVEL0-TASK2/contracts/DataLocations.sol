// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


/*### **数据位置**

### **数据位置 - Storage、Memory 和 Calldata**

变量被声明为 `storage`、`memory` 或 `calldata` 以明确指定数据的位置。

- **`storage`** 变量是状态变量（存储在区块链上）。
- **`memory`** 变量存在于内存中，它在函数调用期间存在。
- **`calldata`** 是特殊的数据位置，包含函数参数。*/

contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;

    struct MyStruct {
        uint256 foo;
    }

    mapping(uint256 => MyStruct) myStructs;

    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do something with storage variables
    }

    // You can return memory variables
    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // do something with memory array
    }

    function h(uint256[] calldata _arr) external {
        // do something with calldata array
    }
}