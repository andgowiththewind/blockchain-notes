pragma solidity ^0.8.24;

// 定义了一个抽象合约 ERC20，这意味着它不能直接被实例化，
// 这个合约是为遵循 ERC20 代币标准的合约定义的接口，可以被其他合约继承并实现。
abstract contract ERC20 {

    // 代币的名称，作为一个公共常量字符串。
    // 在实际实现中，这个值通常会被设置为代币的名称，比如 "MyToken"。
    string public constant name = "";

    // 代币的符号，一般是代币名称的缩写，比如 "MTK"。
    // 在实际实现中，这个符号标识代币。
    string public constant symbol = "";

    // 代币的小数点位数。
    // 这是这个代币支持的最小单位。通常设定为 18，如同以太坊。
    uint8 public constant decimals = 0;

    // 返回代币的总供应量。
    // 虚函数（virtual）表示需要在继承的合约中实现。
    function totalSupply() public view virtual returns (uint);

    // 返回指定地址的账户余额。
    // 参数 tokenOwner 是要查询的账户地址。
    function balanceOf(address tokenOwner) public view virtual returns (uint balance);

    // 返回授权给某个第三方（spender）的代币剩余数量。
    // 参数 tokenOwner 表示代币拥有者，spender 表示被授权使用这些代币的地址。
    function allowance(address tokenOwner, address spender) public view virtual returns (uint remaining);

    // 将指定数量的代币从调用者的账户转移到另一个账户（to）。
    // 返回值表示转账是否成功。
    function transfer(address to, uint tokens) public virtual returns (bool success);

    // 批准 spender 可以从调用者的账户中最多提取指定数量的代币（tokens）。
    // 返回值表示操作是否成功。
    function approve(address spender, uint tokens) public virtual returns (bool success);

    // 使用 transferFrom 方法将代币从一个账户（from）转移到另一个账户（to）。
    // 需要该转移事先经过授权。
    function transferFrom(address from, address to, uint tokens) public virtual returns (bool success);

    // 定义 Transfer 事件，用于记录代币从一个地址转移到另一个地址的操作。
    // 包含发送者地址（from），接收者地址（to）以及转移的代币数量（tokens）。
    event Transfer(address indexed from, address indexed to, uint tokens);

    // 定义 Approval 事件，用于记录代币所有者授权第三方成功的情况。
    // 包含代币拥有者地址（tokenOwner），被授权者地址（spender）以及被授权的代币数量（tokens）。
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
