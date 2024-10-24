package main

import (
	"context"
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

func queryBlockAndTransaction() {
	// 连接到 Ganache
	client, err := ethclient.Dial("http://127.0.0.1:7545")
	if err != nil {
		log.Fatalf("[1849371683123761152]-Failed to connect to the Ethereum client: %v", err)
	}

	// 查询最新区块
	header, err := client.HeaderByNumber(context.Background(), nil)
	if err != nil {
		log.Fatalf("Failed to get latest block: %v", err)
	}

	fmt.Printf("Latest block number: %v\n", header.Number.String())

	// 查询具体区块信息
	block, err := client.BlockByNumber(context.Background(), header.Number)
	if err != nil {
		log.Fatalf("Failed to get block: %v", err)
	}

	fmt.Printf("Block hash: %s\n", block.Hash().Hex())
	fmt.Printf("Block transactions: %d\n", len(block.Transactions()))

	// 查询某个具体交易信息
	txHash := common.HexToHash("PUT_TRANSACTION_HASH_HERE")
	tx, isPending, err := client.TransactionByHash(context.Background(), txHash)
	if err != nil {
		log.Fatalf("Failed to get transaction by hash: %v", err)
	}

	fmt.Printf("Transaction hash: %s\n", tx.Hash().Hex())
	fmt.Printf("Transaction is pending: %v\n", isPending)

	// 查询交易收据
	receipt, err := client.TransactionReceipt(context.Background(), txHash)
	if err != nil {
		log.Fatalf("Failed to get transaction receipt: %v", err)
	}

	fmt.Printf("Transaction receipt status: %v\n", receipt.Status)
	fmt.Printf("Transaction gas used: %v\n", receipt.GasUsed)
	fmt.Printf("Transaction block number: %v\n", receipt.BlockNumber.Uint64())
}
