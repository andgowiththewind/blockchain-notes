package main

import (
	"context"
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {
	// 连接到 Ganache
	client, err := ethclient.Dial("http://127.0.0.1:7545")
	if err != nil {
		log.Fatalf("Failed to connect to the Ethereum client: %v", err)
	}

	// 查询账户余额
	account := common.HexToAddress("0x95801C5e6040F4890BEe8F8Ae9D1396EE8898Bac")
	balance, err := client.BalanceAt(context.Background(), account, nil)
	if err != nil {
		log.Fatalf("Failed to retrieve account balance: %v", err)
	}

	fmt.Printf("Balance of account %s: %s\n", account.Hex(), balance.String())
}
