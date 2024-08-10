// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//以太单位
//交易费用用 `ether` 支付。
//类似于一美元等于 100 分，一 `ether` 等于 10^18 `wei`。
contract EtherUnits {
    unit256 public oneWei = 1 wei;
    bool public isOneWei = (oneWei == 1);

    uint256 public oneGwei = 1 gwei;
    // 1 gwei is equal to 10^9 gwei
    bool public isOneGwei = (oneGwei == 1e9);

    uint256 public oneEther = 1 ether;
    // 1 ether is equal to 10^18 wei
    bool public isOneEther = (oneEther == 1e18);
}
