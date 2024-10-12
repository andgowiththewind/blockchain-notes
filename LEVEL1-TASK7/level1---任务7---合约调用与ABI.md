合约调用与ABI



# 合约与合约之间的调用方式?

## 五种方式

> 区块链中合约与合约之间的调用方式?

在区块链上，特别是以太坊这样的智能合约平台，合约与合约之间的调用是一个常见的操作。以下是一些主要的调用方式和相关概念：

1. **直接调用**：
   - 合约可以在其函数中调用其他合约的函数。调用的方式类似于对象方法调用，使用合约的地址和ABI（应用程序二进制接口）来执行调用。
   - 示例中，在合约A中可以使用`ContractB contractB = ContractB(地址)`来实例化，然后调用`contractB.someFunction()`。

2. **消息调用（Message Call）**：
   - 消息调用是一种低级别的合约调用方式。使用`call`方法，可以将消息发送到另一个合约。
   - 这种调用方式非常灵活，因为它允许发送以太币并设置gas限制，但是错误处理较为复杂，因为它只返回一个布尔值来表示成功与否。

3. **委托调用（Delegatecall）**：
   - `delegatecall`允许一个合约在执行上下文中执行另一个合约的代码。这样被调用的目标合约可以访问原合约的存储。
   - 该方法常用于需要共享代码库的情况，如标准的代理合约模式。

4. **调用静态合约（Staticcall）**：
   - `staticcall`用于不改变区块链状态的只读操作。这是一种对状态不产生副作用的调用。
   - `staticcall`通常用于查询合约的状态。

5. **事件通知**：
   - 虽然不是直接的调用方式，合约之间可以通过事件的发布和监听来通讯。一个合约可以触发某个事件，其他合约通过监听该事件来做出响应。
   

以上这些方法各有优劣，并且适用于不同的场景。选择哪种调用方式通常依赖于具体的需求，例如是否需要改变合约状态、是否涉及到复杂的错误处理、代码复用等方面。另外，在合约交互时务必注意安全性，防止重入攻击和其他潜在的漏洞。

---



下面是一些简单的示例代码，演示每种合约之间调用的方式，以及解释其用途：

### 1. 直接调用

假设有两个合约：`ContractA`和`ContractB`，`ContractA`调用`ContractB`的函数。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 被调用的合约，ContractB
contract ContractB {
    uint public data;

    function setData(uint _data) public {
        data = _data;
    }
}

// 调用合约，ContractA
contract ContractA {
    ContractB public contractB;

    constructor(address _contractBAddress) {
        contractB = ContractB(_contractBAddress);
    }

    function callSetData(uint _data) public {
        contractB.setData(_data);
    }
}
```

### 2. 消息调用（Message Call）

使用`call`来调用另一个合约的函数。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractB {
    uint public data;

    function setData(uint _data) public {
        data = _data;
    }
}

contract ContractA {
    function callB(address _contractBAddress, uint _data) public returns (bool) {
        (bool success, ) = _contractBAddress.call(
            abi.encodeWithSignature("setData(uint256)", _data)
        );
        return success;
    }
}
```

给我有种Java中反射调用的感觉。



### 3. 委托调用（Delegatecall）

使用`delegatecall`可在另一个合约的上下文中执行代码。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractB {
    uint public data;

    function setData(uint _data) public {
        data = _data;
    }
}

contract ContractA {
    uint public data;

    function delegateCall(address _contractBAddress, uint _data) public returns (bool) {
        (bool success, ) = _contractBAddress.delegatecall(
            abi.encodeWithSignature("setData(uint256)", _data)
        );
        return success;
    }
}
```

### 4. 调用静态合约（Staticcall）

使用`staticcall`用于不改变状态的只读操作。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractB {
    function getData() public pure returns (string memory) {
        return "Hello from Contract B";
    }
}

contract ContractA {
    function getDataFromB(address _contractBAddress) public view returns (string memory) {
        (bool success, bytes memory data) = _contractBAddress.staticcall(
            abi.encodeWithSignature("getData()")
        );
        require(success, "Call failed");
        return abi.decode(data, (string));
    }
}
```

### 5. 事件通知

一个合约触发事件，另一个合约或外部服务监听。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractA {
    event DataChanged(uint data);

    uint public data;

    function changeData(uint _data) public {
        data = _data;
        emit DataChanged(_data);
    }
}

// 在另一个合约中，你不能直接监听事件，但你可以编写一个合约或者外部应用来订阅这些事件。
```

这些示例演示了基本的合约交互方法。使用这些技术时，注意选择适合的调用方式，并留意潜在的安全问题，如重入攻击的防范。







# 合约`ABI`

> 讲解一下合约ABI，如果类比Java，它相当于Java知识体系中的哪个知识点？

---

合约的ABI（Application Binary Interface，应用程序二进制接口）是用于与智能合约进行交互的接口描述。它定义了合约中可用的函数和事件，以及如何编码和解码参数和返回值。在以太坊和其他区块链平台中，ABI用于指导应用程序如何与合约进行深入沟通。

### 合约ABI的组成

1. **函数描述**：包括函数名称、输入参数及其类型、输出参数及其类型等信息。
2. **事件描述**：定义事件的名称和参数类型，用于在事件触发时正确处理日志。
3. **编码规则**：参数的编码和解码格式，使得合约调用和事件监听能够正确地解析为透明的二进制数据。

### 类比Java中的知识点

在Java的知识体系中，ABI可以类比为**接口（Interface）**或**API描述**。理由如下：

- **接口（Interface）**：Java接口定义了类必须实现的方法。类似地，ABI定义了合约必须实现的函数及其参数。它们都规定了允许外部交互的操作契约。

- **API描述**：Java API文档记录了类和方法的用法，ABI则记录了合约的函数和事件定义，包括调用方法、参数类型等，用于指导智能合约调用者正确使用合约功能。

### 使用ABI

开发者通过ABI能够生成适配的客户端代码，用于调用合约的方法。例如，在JavaScript中使用Web3.js库与以太坊智能合约交互时，需要提供ABI来正确调用合约的函数。ABI的结构与接口、API的概念有相似之处，就是它们用于描述特定代码中的功能和约定，以便开发者或其他代码模块可以高效、准确地进行调用和交互。

---



# 是否收费？

在与以太坊智能合约交互时，是否需要付费取决于所执行的操作类型。以下是一些情况的说明：

1. **读取操作（Read Operations）**：
   - 对于读取合约状态的操作（调用`view`或`pure`标记的函数），这是免费的。这些操作不需要写入区块链，因此不消耗Gas。
   - 因为这些操作只是从节点获取数据，计算是本地执行的，没有任何状态改变的费用。

2. **写入操作（Write Operations）**：
   - 执行改变区块链状态的操作（例如，发送交易、修改合约存储）是需要付费的。这类操作消耗Gas。
   - 每当发送交易来调用合约的函数时，不管是部署合约、转移Ether、修改存储等等，都需要支付以太坊网络的费用，即Gas。Gas费用由组合如下：
     - **Gas Price**：您愿意为每单位Gas支付多少Ether。
     - **Gas Limit**：允许花费的最大Gas量，确保您的合约运行情况。

3. **发送Ether**：
   - 仅仅是通过智能合约发送以太币，也会消耗Gas，此时主要涉及转账处理上的费用。

实际使用中，通过Web3.js与合约进行交互，如果涉及写操作（例如，调用变更合约状态的功能），则需要拥有一个以太坊账户且钱包中有足够的以太币（ETH）来支付网络交易费用。读操作不需要支付费用，因为没有交易产生。 

总之，直接与区块链交互不发生费用的只有读取这样不改变状态的请求，而任何可能引起状态变更的操作都需要使用一定的Gas费。

---



# `Web3.js`调用的demo

---

以下是一个使用Web3.js与以太坊智能合约交互的基本示例。我们假设你已经有一个合约部署在以太坊测试网络上，并且你有相应的合约ABI和合约地址。

### 准备工作

确保你已经安装了Web3.js库。如果没有安装，可以使用以下命令进行安装：

```bash
npm install web3
```

### 示例代码

这个示例代码展示了如何通过Web3.js与一个简单的智能合约进行交互，包括读取一个数值和修改一个数值。

```javascript
const Web3 = require('web3');

// 连接到以太坊节点（这里使用Infura的Ropsten测试网服务）
const web3 = new Web3('https://ropsten.infura.io/v3/YOUR_INFURA_PROJECT_ID');

// 合约ABI
const contractABI = [
    // Replace this with your contract's ABI
    {
        "constant": true,
        "inputs": [],
        "name": "getValue",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_value",
                "type": "uint256"
            }
        ],
        "name": "setValue",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    }
];

// 合约地址
const contractAddress = 'YOUR_CONTRACT_ADDRESS';

// 创建合约实例
const contract = new web3.eth.Contract(contractABI, contractAddress);

// 读取合约值
async function readValue() {
    try {
        const value = await contract.methods.getValue().call();
        console.log('Value from contract:', value);
    } catch (error) {
        console.error('Error reading value', error);
    }
}

// 写入合约值
async function writeValue(newValue) {
    const account = 'YOUR_ACCOUNT_ADDRESS';  // 你的以太坊账户地址
    const privateKey = 'YOUR_PRIVATE_KEY';   // 你的私钥

    try {
        const data = contract.methods.setValue(newValue).encodeABI();

        const transaction = {
            to: contractAddress,
            data: data,
            gas: 2000000,
        };

        const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
        
        const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        console.log('Transaction receipt:', receipt);
    } catch (error) {
        console.error('Error writing value', error);
    }
}

// 执行例子
readValue();  // 读取并输出合约的当前值
writeValue(42);  // 更新合约中的值为42
```

### 注意事项

1. **安全性**：在生产环境中，切勿直接在代码中硬编码私钥。这会带来安全风险。考虑使用环境变量或配置文件进行安全管理。
   
2. **Gas费**：发送交易设置Gas费用时要小心，确保足够的Ether在账户中以支付费用。
   
3. **网络配置**：测试网络通常比主网络更经济地测试和调试合约交互，因此推荐在测试网络上进行开发和测试。

4. **私钥安全**：私钥管理要非常小心，避免在任何代码仓库中暴露私钥。

在本示例中，你需要替换`YOUR_INFURA_PROJECT_ID`、`YOUR_CONTRACT_ADDRESS`、`YOUR_ACCOUNT_ADDRESS`和`YOUR_PRIVATE_KEY`等占位符为你的实际数据。

---



