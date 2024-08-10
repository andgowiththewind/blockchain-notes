// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*### 主要部分分析

1. **状态变量**：
- `uint256[] public arr;`：一个动态数组 `arr` 用于存储 `uint256` 类型的元素。这个数组对外部公开，可以通过合约实例访问其内容。

2. **`remove` 函数**：
- **输入**：`uint256 _index` - 要删除的元素的索引。
- **功能**：
- **检查索引有效性**：`require(_index < arr.length, "index out of bound");` 确保索引在有效范围内。
- **移位操作**：从指定索引 `_index` 开始，将数组中每个后续元素向前移动一位。`for (uint256 i = _index; i < arr.length - 1; i++) { arr[i] = arr[i + 1]; }`
- **删除最后一个元素**：通过 `arr.pop();` 删除数组的最后一个元素。这样做是因为在移位操作后，数组的末尾仍然保留了旧的元素值。

3. **`test` 函数**：
- **功能**：
- **初始化数组并测试 `remove` 函数**：将数组设置为 `[1, 2, 3, 4, 5]`，然后删除索引为 2 的元素，预期结果是 `[1, 2, 4, 5]`。通过 `assert` 语句验证结果是否正确。
- **测试边界情况**：将数组设置为 `[1]`，然后删除唯一的元素，预期结果是空数组 `[]`，并通过 `assert` 验证结果。

### 理解及比较

- **Java 中的类比**：
- **动态数组**（`uint256[]`）类似于 Java 中的 `ArrayList`。
- **移位操作**（`for` 循环）相当于在 Java 中使用 `ArrayList` 的 `remove` 方法时，手动处理元素移位的过程。
- **`assert`** 用于验证，类似于 Java 中的单元测试框架（如 JUnit）中的断言功能。
- **`pop` 方法**：在 Java 中的 `ArrayList` 使用 `remove` 或 `removeAt` 方法来移除元素，而在 Solidity 中，`pop` 用于移除数组的最后一个元素。

### 总结

这段代码演示了如何在 Solidity 中使用移位操作来从动态数组中删除指定的元素，并且通过 `test` 函数验证了 `remove` 函数的正确性。对于 Java 工程师而言，这段代码展示了如何在区块链合约中处理动态数组的元素删除问题，同时提供了一种理解 Solidity 数据操作的视角。*/
contract ArrayRemoveByShifting {
    // 动态数组声明
    uint256[] public arr;

    // 删除指定索引的元素
    function remove(uint256 _index) public {
        require(_index < arr.length, "index out of bound");

        // 从指定索引开始，逐个将后续元素向前移动一位
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        // 移除数组最后一个元素
        arr.pop();
    }

    // 测试函数
    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // 结果：[1, 2, 4, 5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        // 结果：[]
        assert(arr.length == 0);
    }
}
