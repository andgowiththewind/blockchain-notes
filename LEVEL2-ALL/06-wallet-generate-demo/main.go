package main

import (
	// 导入必要的包
	"crypto/ecdsa"                                   // ECDSA是用于生成公私钥对的加密算法。
	"fmt"                                            // fmt包用于格式化I/O输出。
	"github.com/ethereum/go-ethereum/common/hexutil" // hexutil包用于将二进制数据进行16进制编码。
	"github.com/ethereum/go-ethereum/crypto"         // crypto包提供了以太坊cryptographic操作的工具。
	"golang.org/x/crypto/sha3"                       // sha3包用于SHA3哈希算法。
	"log"                                            // log包用于日志记录。
)

func main() {
	// 生成新的ECDSA私钥
	privateKey, err := crypto.GenerateKey()
	if err != nil {
		// 如果出现错误，日志记录并退出程序
		log.Fatal(err)
	}

	// 将私钥转换为字节数组
	privateKeyBytes := crypto.FromECDSA(privateKey)
	// 打印私钥的16进制字符串表示（去掉前缀"0x"）
	fmt.Println(hexutil.Encode(privateKeyBytes)[2:]) // 输出私钥的16进制表示

	// 提取公钥
	// 私钥对象包含其公钥部分
	publicKey := privateKey.Public()
	// 强制转换为ECDSA公钥类型，并检查转换是否成功
	publicKeyECDSA, ok := publicKey.(*ecdsa.PublicKey)
	if !ok {
		// 如果转换失败，记录致命错误并退出
		log.Fatal("cannot assert type: publicKey is not of type *ecdsa.PublicKey")
	}

	// 将公钥对象转换为字节数组
	publicKeyBytes := crypto.FromECDSAPub(publicKeyECDSA)
	// 打印公钥的16进制字符串表示（去掉椭圆曲线点格式的前缀）
	fmt.Println(hexutil.Encode(publicKeyBytes)[4:]) // 输出公钥的16进制表示

	// 计算以太坊地址
	// 以太坊地址是公钥的Keccak256哈希的后20字节（相当于对公钥进行编码）
	address := crypto.PubkeyToAddress(*publicKeyECDSA).Hex()
	// 打印以太坊地址
	fmt.Println(address)

	// 创建Keccak256哈希的实例
	hash := sha3.NewLegacyKeccak256()
	// 对压缩格式的公钥（去掉前缀符号部分）进行哈希
	hash.Write(publicKeyBytes[1:])
	// 打印哈希值的后20字节
	fmt.Println(hexutil.Encode(hash.Sum(nil)[12:]))
}
