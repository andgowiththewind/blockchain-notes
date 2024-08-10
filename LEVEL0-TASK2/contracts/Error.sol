// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


/*一个错误会撤销事务期间对状态所做的所有更改。

你可以通过调用 `require`、`revert` 或 `assert` 来抛出错误。

- `require` 用于在执行前验证输入和条件。
- `revert` 类似于 `require`，用于在条件不满足时撤销操作。详情见下面的代码。
- `assert` 用于检查应永远为真的代码。断言失败通常意味着存在 bug。

使用自定义错误可以节省 gas。*/
contract Error {
    function testRequire(uint256 _i) public pure {
        // Require should be used to validate conditions such as:
        // - inputs
        // - conditions before execution
        // - return values from calls to other functions
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        // Revert is useful when the condition to check is complex.
        // This code does the exact same thing as the example above
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        // Assert should only be used to test for internal errors,
        // and to check invariants.

        // Here we assert that num is always equal to 0
        // since it is impossible to update the value of num
        assert(num == 0);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}