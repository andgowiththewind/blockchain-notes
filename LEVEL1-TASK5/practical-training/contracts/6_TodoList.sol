// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract TodoList {
    // 设计一个结构体Task
    struct Task {
        string name;
        bool isCompleted;
    }
    // 定义一个Task类型的数组tasks，用于存储所有的任务
    Task[] public tasks;

    // 创建任务
    function createTask(string memory _name) external {
        tasks.push(Task(_name, false));
    }

    // 修改任务名称
    function updateTaskName(uint256 _index, string memory _name) external {
        tasks[_index].name = _name;
    }

    // 修改任务名称
    function updateTaskName2(uint256 _index, string memory _name) external {
        Task storage task = tasks[_index];
        task.name = _name;
    }

    // 修改任务状态:自动切换任务状态
    function toggleTaskStatus(uint256 _index) external {
        tasks[_index].isCompleted = !tasks[_index].isCompleted;
    }

    // 修改任务状态:指定任务状态
    function updateTaskStatus(uint256 _index, bool _isCompleted) external {
        tasks[_index].isCompleted = _isCompleted;
    }

    // 获取
    function getTask(uint256 _index) external view returns (string memory name, bool isCompleted) {
        Task memory task = tasks[_index];
        name = task.name;
        isCompleted = task.isCompleted;
    }
}
