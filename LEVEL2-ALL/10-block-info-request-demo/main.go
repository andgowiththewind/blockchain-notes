package main // 定义主包

import (
	"context"  // 导入 context 包，用于处理上下文
	"fmt"      // 导入 fmt 包，用于格式化 I/O
	"log"      // 导入 log 包，用于记录日志信息
	"math/big" // 导入 big 包，用于处理大整数

	"github.com/ethereum/go-ethereum/ethclient" // 导入 go-ethereum 的 ethclient 包，以连接以太坊客户端
)

func main() {
	// 使用 Cloudflare 的以太坊节点创建一个以太坊客户端连接
	//client, err := ethclient.Dial("https://cloudflare-eth.com")
	client, err := ethclient.Dial("http://127.0.0.1:7545")
	if err != nil { // 如果连接出错，记录日志并终止程序
		log.Fatal(err)
	}

	// 获取最新区块头信息，使用 nil 表示最新区块
	header, err := client.HeaderByNumber(context.Background(), nil)
	if err != nil { // 如果获取头信息出错，记录日志并终止程序
		log.Fatal(err)
	}

	// 打印当前区块的编号，转为字符串形式
	fmt.Println(header.Number.String()) // 5671744

	// 创建一个新的大整数，表示特定的区块编号
	blockNumber := big.NewInt(5671744)
	// 根据区块编号获取该区块的信息
	block, err := client.BlockByNumber(context.Background(), blockNumber)
	if err != nil { // 如果获取区块信息出错，记录日志并终止程序
		log.Fatal(err)
	}

	// 打印区块编号，使用 Uint64() 转换为无符号整数
	fmt.Println(block.Number().Uint64()) // 5671744
	// 打印区块的时间戳
	fmt.Println(block.Time()) // 1527211625
	// 打印区块的难度值，使用 Uint64() 转换为无符号整数
	fmt.Println(block.Difficulty().Uint64()) // 3217000136609065
	// 打印区块的哈希值，使用 Hex() 转换为十六进制字符串
	fmt.Println(block.Hash().Hex()) // 0x9e8751ebb5069389b855bba72d94902cc385042661498a415979b7b6ee9ba4b9
	// 打印该区块中的交易数量
	fmt.Println(len(block.Transactions())) // 144

	// 获取与该区块哈希对应的交易计数
	count, err := client.TransactionCount(context.Background(), block.Hash())
	if err != nil { // 如果计数出错，记录日志并终止程序
		log.Fatal(err)
	}

	// 打印该区块中的交易数量
	fmt.Println(count) // 144
}
