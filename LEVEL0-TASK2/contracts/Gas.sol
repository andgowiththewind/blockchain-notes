// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*### **Gas**
### **你需要支付多少 `ether` 来进行一笔交易？**
你支付 `gas spent * gas price` 数量的 `ether`，其中
- `gas` 是计算的单位
- `gas spent` 是交易中使用的总 `gas` 数量
- `gas price` 是你愿意为每单位 `gas` 支付的 `ether` 数量
交易的 gas price 越高，越有优先级被包含到区块中。
未使用的 gas 会被退还。
### **Gas Limit**
你可以支出的 gas 量有两个上限：
- `gas limit`（你愿意为交易使用的最大 gas 量，由你设置）
- `block gas limit`（区块中允许的最大 gas 量，由网络设置）*/
contract Gas {
    unint256 public i = 0;

    // 使用完你发送的所有 gas 会导致交易失败。
    // 状态更改会被撤销。
    // 已花费的 gas 不会被退还。
    function forever() public {
        while (true) {
            i += 1;
        }
    }
}
