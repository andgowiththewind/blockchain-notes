package main

import (
	hdwallet "github.com/miguelmota/go-ethereum-hdwallet"
	"log"
	"math/big"

	"github.com/davecgh/go-spew/spew"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
)

func main() {
	mnemonic := "tag volcano eight thank tide danger coast health above argue embrace heavy"
	wallet, err := hdwallet.NewFromMnemonic(mnemonic)
	if err != nil {
		log.Fatal(err)
	}

	path := hdwallet.MustParseDerivationPath("m/44'/60'/0'/0/0")
	account, err := wallet.Derive(path, true)
	if err != nil {
		log.Fatal(err)
	}

	nonce := uint64(0)                       // 设置交易 nonce
	value := big.NewInt(1000000000000000000) // 转账金额，1 ETH
	//toAddress := common.HexToAddress("0x0")  // 收款地址（请替换为实际地址）
	toAddress := common.HexToAddress("0xC49926C4124cEe1cbA0Ea94Ea31a6c12318df947") // 收款地址（请替换为实际地址）
	gasLimit := uint64(21000)                                                      // 交易的 gas limit
	gasPrice := big.NewInt(21000000000)                                            // gas price（单位 wei）
	var data []byte                                                                // 交易数据（对于简单的转账可以留空）

	// 构造交易
	tx := types.NewTransaction(nonce, toAddress, value, gasLimit, gasPrice, data)
	signedTx, err := wallet.SignTx(account, tx, nil)
	if err != nil {
		log.Fatal(err)
	}

	spew.Dump(signedTx) // 打印签署后的交易
}
