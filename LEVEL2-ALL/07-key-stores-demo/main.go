package main

import (
	"fmt"                                               // 导入用于格式化 I/O 操作的 fmt 包
	"github.com/ethereum/go-ethereum/accounts/keystore" // 导入 go-ethereum 的 keystore 包，用于管理以太坊账户密钥
	"io/ioutil"                                         // 导入用于读写文件的 ioutil 包
	"log"                                               // 导入用于日志记录的 log 包
	"os"                                                // 导入用于与操作系统交互的 os 包
)

// createKs 函数用于创建一个新的以太坊账户并将其存储在 keystore 中
func createKs() {
	// 创建一个新的 keystore，文件存储在 "./tmp" 目录中
	// 标准参数 keystore.StandardScryptN 和 keystore.StandardScryptP 为密码加密使用的参数
	ks := keystore.NewKeyStore("./tmp", keystore.StandardScryptN, keystore.StandardScryptP)

	// 定义账户的密码
	password := "mypassword2024"

	// 创建新账户并使用指定的密码
	account, err := ks.NewAccount(password)
	if err != nil {
		// 如果创建账户时出现错误，记录并退出程序
		log.Fatal(err)
	}

	// 打印新创建账户的地址
	fmt.Println(account.Address.Hex()) // 输出账户地址，例如: 0x20F8D42FB0F667F2E53930fed426f225752453b3
}

// importKs 函数用于导入现有的 keystore 文件并恢复账户
func importKs() {
	// 指定要导入的 keystore 文件路径
	file := "./tmp/UTC--2024-10-22T14-20-20.286671700Z--8a3e379bf3554745893095e12b016d641cc40d6b"

	// 创建与 createKs 相同的 keystore 实例>>>>>改了目录
	ks := keystore.NewKeyStore("./tmp2", keystore.StandardScryptN, keystore.StandardScryptP)

	// 读取指定文件内容
	jsonBytes, err := ioutil.ReadFile(file)
	if err != nil {
		// 如果读取文件时出现错误，记录并退出程序
		log.Fatal(err)
	}

	// 定义账户的密码
	password := "mypassword2024"

	// 导入 keystore 文件中的账户，使用同样的密码进行解锁
	account, err := ks.Import(jsonBytes, password, password)
	if err != nil {
		// 如果导入账户时出现错误，记录并退出程序
		log.Fatal(err)
	}

	// 打印导入账户的地址
	fmt.Println(account.Address.Hex()) // 输出导入账户的地址，例如: 0x20F8D42FB0F667F2E53930fed426f225752453b3

	// 删除导入的文件以清理临时文件
	if err := os.Remove(file); err != nil {
		// 如果删除文件时出现错误，记录并退出程序
		log.Fatal(err)
	}
}

// main 函数是程序的入口点
func main() {
	//createKs() // 调用 createKs 函数创建新账户
	importKs() // 可以取消注释此行以导入现有账户
}
