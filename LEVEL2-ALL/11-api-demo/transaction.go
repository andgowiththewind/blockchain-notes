package main

import (
	"context"
	"crypto/ecdsa"
	"fmt"
	"log"
	"math/big"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
)

func createTransaction() {
	// 连接到 Ganache
	client, err := ethclient.Dial("http://127.0.0.1:7545")
	if err != nil {
		log.Fatalf("[1849371683123761153]-Failed to connect to the Ethereum client: %v", err)
	}

	// 账户1私钥和地址
	//privateKey1, err := crypto.HexToECDSA("PUT_PRIVATE_KEY_1_HERE")
	privateKey1, err := crypto.HexToECDSA("f11f576ebd0578afdf004b49038a1a612956e57a0b7288e7022b346b671c9a97")
	if err != nil {
		log.Fatalf("[1849371683123761154]-Failed to parse private key: %v", err)
	}

	publicKey1 := privateKey1.Public()
	publicKeyECDSA1, ok := publicKey1.(*ecdsa.PublicKey)
	if !ok {
		log.Fatal("[1849371683123761155]-Cannot assert type: publicKey is not of type *ecdsa.PublicKey")
	}

	fromAddress := crypto.PubkeyToAddress(*publicKeyECDSA1)

	// 账户2地址
	//toAddress := common.HexToAddress("PUT_ACCOUNT_ADDRESS_2_HERE")
	toAddress := common.HexToAddress("c1e10bc6f91cbbf051840fa52e11190a8bbc8724c7dcecaa70558415425dae94")

	// 获取 nonce
	nonce, err := client.PendingNonceAt(context.Background(), fromAddress)
	if err != nil {
		log.Fatalf("[1849371683123761156]-Failed to get account nonce: %v", err)
	}

	// 设置交易值
	value := big.NewInt(1000000000000000000) // 1 ether

	// 设置 gas limit 和 gas price
	gasLimit := uint64(21000) // 单位 gas
	gasPrice, err := client.SuggestGasPrice(context.Background())
	if err != nil {
		log.Fatalf("[1849371683123761157]-Failed to suggest gas price: %v", err)
	}

	// 创建交易
	tx := types.NewTransaction(nonce, toAddress, value, gasLimit, gasPrice, nil)

	// 签署交易
	chainID, err := client.NetworkID(context.Background())
	if err != nil {
		log.Fatalf("[1849371683123761158]-Failed to get network ID: %v", err)
	}

	signedTx, err := types.SignTx(tx, types.NewEIP155Signer(chainID), privateKey1)
	if err != nil {
		log.Fatalf("[1849371683123761160]-Failed to sign transaction: %v", err)
	}

	// 发送交易
	err = client.SendTransaction(context.Background(), signedTx)
	if err != nil {
		log.Fatalf("[1849371683123761161]-Failed to send transaction: %v", err)
	}

	fmt.Printf("[1849372161693847552]-Transaction sent: %s\n", signedTx.Hash().Hex())
}
