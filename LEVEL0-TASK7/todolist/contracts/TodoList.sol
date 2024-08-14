// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TodoList {
    // 任务计数器，用于跟踪总任务数量
    uint public taskCount = 0;

    // 定义任务结构体
    struct Task {
        uint id; // 任务ID
        string taskname; // 任务名称
        bool status; // 任务状态：已完成或未完成
    }

    // 创建一个映射，将任务ID映射到任务
    mapping(uint => Task) public tasks;

    // 任务创建事件
    event TaskCreated(
        uint id,
        string taskname,
        bool status
    );

    // 任务状态切换事件
    event TaskStatus(
        uint id,
        bool status
    );

    // 构造函数，在合约部署时自动调用，并创建一个默认任务
    constructor() {
        createTask("Todo List Tutorial");
    }

    // 创建新任务的函数
    function createTask(string memory _taskname) public {
        taskCount ++; // 增加任务计数
        // 创建新任务并存储到映射中
        tasks[taskCount] = Task(taskCount, _taskname, false);
        // 触发任务创建事件
        emit TaskCreated(taskCount, _taskname, false);
    }

    // 切换任务状态的函数
    function toggleStatus(uint _id) public {
        // 从映射中获取任务
        Task memory _task = tasks[_id];
        // 切换任务状态
        _task.status = !_task.status;
        // 更新映射中的任务
        tasks[_id] = _task;
        // 触发任务状态切换事件
        emit TaskStatus(_id, _task.status);
    }
}
