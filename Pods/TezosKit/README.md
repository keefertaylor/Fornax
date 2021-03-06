# TezosKit &nbsp;&nbsp;&nbsp; [![Build Status](https://travis-ci.org/keefertaylor/TezosKit.svg?branch=master)](https://travis-ci.org/keefertaylor/TezosKit) &nbsp;&nbsp;&nbsp;  [![codecov](https://codecov.io/gh/keefertaylor/TezosKit/branch/master/graph/badge.svg)](https://codecov.io/gh/keefertaylor/TezosKit)

TezosKit is a Swift library that is compatible with the [Tezos Blockchain](https://tezos.com). TezosKit implements communication with the blockchain via the JSON API.

Donations help me find time to work on TezosKit. If you find the library useful, please consider donating to support ongoing develoment.

|Currency| Address |
|---------|---|
| __Tezos__ | tz1SNXT8yZCwTss2YcoFi3qbXvTZiCojx833 |
| __Bitcoin__ | 1CdPoF9cvw3YEiuRCHxdsGpvb5tSUYBBo |
| __Bitcoin Cash__ | qqpr9are9gzs5r0q7hy3gdehj3w074pyqsrhpdmxg6 |


## Functionality

TezosKit provides first class support for the following RPCs:
* Getting account balances
* Getting data about the chain head
* Getting account delegates 
* Generating and restoring wallets 
* Sending transactions between accounts
* Sending multiple operations in a single request
* Setting / clearing delegates
* Registering as a delegate
* Originating accounts
* (With more coming soon!)

The library is extensible allowing client code to easily create additional RPCs and signed operations, as required. 

TesosKit takes care of complex block chain interactions for you:
* Addresses are revealed automatically, if needed
* Sending multiple operations by passing them in an array

TezosKit is heavily inspired by functionality provided by other Tezos SDKs, such as [eztz](https://github.com/TezTech/eztz) or [TezosJ](https://github.com/LMilfont/TezosJ-plainjava).

## Installation

### CocoaPods
TezosKit supports installation via CocoaPods. You can depened on TezosKit by adding the following to your Podfile:

```
pod "TezosKit", :git => 'https://github.com/keefertaylor/TezosKit.git'
```

### LibSodium Errors

If you receive build errors about missing headers for Sodium, you need to install the LibSodium library.

The easiest way to do this is with Homebrew:

```shell
$ brew update && brew install libsodium
```

## Getting Started

### Create a Network Client

```swift
let publicNodeURL = URL(string: "https://rpc.tezrpc.me")!
let tezosClient = TezosClient(remoteNodeURL: publicNodeURL)
```

### Retrieve Data About the Blockchain

```swift
tezosClient.getHead() { (result: [String: Any]?, error: Error?) in
  guard let result = result,
        let metadata: = result["metadata"] as? [String : Any],
        let baker = metadata["baker"]  else {
    return
  }
  print("Baker of the block at the head of the chain is \(baker)")
}
```

### Retrieve Data About a Contract

```swift
let address = "KT1BVAXZQUc4BGo3WTJ7UML6diVaEbe4bLZA" // http://tezos.community
tezosClient.getBalance(address: address) { (balance: TezosBalance?, error: Error?) in
  guard let balance = balance else {
    return
  }
  print("Balance of \(address) is \(balance.humanReadableRepresentation)")
}
```

### Create a Wallet

```swift
let wallet = Wallet()
print("New wallet mnemonic is: \(wallet.mnemonic)")
```

### Send a Transaction

```swift
let wallet = Wallet()
let sendAmount = TezosBalance(balance: 1.0)!
let recipientAddress = ...
tezosClient.send(amount: sendAmount,
                 to recipientAddress: recipientAddress,
                 from address: wallet.address,
                 secretKey: wallet.secretKey) { (txHash, txError) in 
  print("Transaction sent. See: https://tzscan.io/\(txHash!)")
}
```

### Send Multiple Transactions at Once

Here's an example of how you can send multiple transactions at once. You 
can easily send Jim and Bob some XTZ in one call:

```swift
let myWallet: Wallet = ...
let jimsAddress: String = tz1...
let bobsAddress: String = tz1...

let amountToSend = TezosBalance("2")!

let sendToJimOperation = TransactionOperation(amount: amountToSend,
                                              source: myWallet,
                                              destination: jimsAddress)
let sendToBobOperation = TransactionOperation(amount: amountToSend,
                                              source: myWallet,
                                              destination: bobsAddress)

let operations = [ sendToJimOperation, sendToBobOperation ]
tezosClient.forgeSignPreapplyAndInjectOperations(operations: operations,
                                                 source: myWallet.address,
                                                 keys: myWallet.keys) { (txHash, error) in
  print("Sent Jim and Bob some XTZ! See: https://tzscan.io/\(txHash!)")
}
```

### Set a Delegate

```swift
let wallet = ...
let originatedAccountAddress = <Some Account Managed By Wallet>
let delegateAddress = ...
tezosClient.delegate(from: originatedAccountAddress,
                     to: delegateAddress,
                     keys: wallet.keys) { (txHash, txError) in 
  print("Delegate for \(originatedAccountAddress) set to \(delegateAddress).")
  print("See: https://tzscan.io/\(txHash!)")
}
```

## Contributing

I am happy to accept pull requests. 

## License

MIT
