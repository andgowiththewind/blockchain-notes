// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract Crowdfund {
    address public immutable beneficiary; // 受益人
    uint256 public immutable fundingGoal; // 目标金额
    uint256 public currentAmount; // 当前金额

    // 资助者MAP, 资助者地址 => 资助金额
    mapping(address => uint256) public funderMap;

    // 资助者列表, 地址集合
    address[] public funderList;
    // 为了方便处理资助者列表,再设计一个map记录资助者是否存在
    mapping(address => bool) public funderExistMap;

    // 当前合约状态：是否启用
    bool public IS_ENABLED = true;

    // 构造函数：部署的时候写入受益人和目标金额
    constructor(address _beneficiary, uint256 _fundingGoal) {
        beneficiary = _beneficiary;
        fundingGoal = _fundingGoal;
    }

    // 接收资助
    function contribute() external payable {
        require(IS_ENABLED, "Crowdfund: contract is disabled"); // 合约是否启用
        require(msg.value > 0, "Crowdfund: contribution must be greater than 0"); // 资助金额必须大于0

        // 检查本次捐赠金额是否会超过目标金额,如果超过则退回多余的金额
        uint256 advanceAmount = currentAmount + msg.value; // 当前金额+本次捐赠金额
        uint256 refundAmount = 0; // 退款金额
        uint256 actualAmount = msg.value; // 实际捐赠金额

        if (advanceAmount > fundingGoal) {
            refundAmount = advanceAmount - fundingGoal;
            actualAmount = msg.value - refundAmount;
        }

        // 记录本次捐赠者
        if (!funderExistMap[msg.sender]) {
            funderExistMap[msg.sender] = true;
            funderList.push(msg.sender);
        }
        // 如果不简写：funderMap[msg.sender] = funderMap[msg.sender] + actualAmount;
        funderMap[msg.sender] += actualAmount;

        // 更新当前金额
        currentAmount += actualAmount;

        // 如果有退款金额,则退款
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }

    // 关闭合约
    function close() external returns (bool) {
        require(IS_ENABLED, "Crowdfund: contract is disabled"); // 合约是否启用
        require(msg.sender == beneficiary, "Crowdfund: only beneficiary can close"); // 只有受益人可以关闭合约
        require(currentAmount >= fundingGoal, "Crowdfund: funding goal not reached"); // 未达到目标金额

        // 关闭合约
        IS_ENABLED = false;

        // 转账给受益人
        payable(beneficiary).transfer(currentAmount);

        return true;
    }

    // 查看资助者人数
    function getFunderCount() external view returns (uint256) {
        return funderList.length;
    }
}
