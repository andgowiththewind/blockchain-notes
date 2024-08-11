pragma solidity >=0.4.25 <0.9.0;

//Shipping:船运
/*此合约 Shipping 用于管理和追踪货物的运输状态。通过枚举类型 ShippingStatus，合约清晰地定义了货物的不同状态，
并提供了相应的函数来更新和获取当前状态。每当状态发生变化时，合约会触发一个事件 LogNewAlert，
这对于在区块链上进行状态跟踪和通知是非常有用的。
这个合约设计简单且易于理解，非常适合用来学习 Solidity 中的枚举、事件和基本的状态管理。*/
contract Shipping {
    // 定义一个枚举类型，表示货物的运输状态
    enum ShippingStatus { Pending, Shipped, Delivered }

    // 使用枚举类型的变量来保存当前的运输状态
    ShippingStatus private status;

    // 定义一个事件，当包裹到达时触发此事件
    event LogNewAlert(string description);

    // 构造函数：合约初始化时，将状态设置为 Pending
    constructor() {
        status = ShippingStatus.Pending;
    }

    // 函数：将状态更改为 Shipped（已发货）
    function Shipped() public {
        status = ShippingStatus.Shipped;
        // 触发事件，通知包裹已发货
        emit LogNewAlert("Your package has been shipped");
    }

    // 函数：将状态更改为 Delivered（已送达）
    function Delivered() public {
        status = ShippingStatus.Delivered;
        // 触发事件，通知包裹已送达
        emit LogNewAlert("Your package has arrived");
    }

    // 内部函数：根据传入的状态返回对应的字符串
    function getStatus(ShippingStatus _status) internal pure returns (string memory) {
        // 检查当前状态并返回相应的状态名称
        if (ShippingStatus.Pending == _status) return "Pending";
        if (ShippingStatus.Shipped == _status) return "Shipped";
        if (ShippingStatus.Delivered == _status) return "Delivered";
    }

    // 公共函数：获取当前货物的运输状态
    function Status() public view returns (string memory) {
        // 调用内部函数 getStatus，将当前状态转换为字符串返回
        ShippingStatus _status = status;
        return getStatus(_status);
    }
}
