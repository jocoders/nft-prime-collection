# Smart Contract Ecosystem: NFT Enumerable Contracts

## CollectionNFT & CounterNFT

**Overview**

This project consists of two Solidity smart contracts designed to interact with NFTs based on the ERC721 standard. `CollectionNFT` creates a fixed collection of 100 NFTs, while `CounterNFT` provides a function to count how many NFTs owned by a specific address have prime number token IDs.

**Features**

- **NFT Minting**: Automatically mints 100 NFTs to the deployer's address.
- **Prime Number Identification**: Identifies which NFTs have prime number token IDs.
- **ERC721 and ERC721Enumerable**: Utilizes OpenZeppelin's implementations for standard NFT functionality and enumerable extensions.

**Technology**

The contracts are written in Solidity and make use of the OpenZeppelin contracts library for secure, standard implementations of ERC721 token functionalities. The project is set up to be tested and deployed using Foundry, a Solidity development environment and testing framework.

**Getting Started**

**Prerequisites**

- Node.js and npm
- Foundry (for local deployment and testing)

**Installation**

1. Install Foundry if it's not already installed:

   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. Clone the repository:

   ```bash
   git clone https://github.com/jocoders/nft-prime-collection.git
   cd nft-prime-collection
   ```

3. Install dependencies:

   ```bash
   forge install
   ```

**Testing**

Run tests using Foundry:

```bash
forge test
```

**Usage**

**Deploying the Contracts**

Deploy the contracts to a local blockchain using Foundry:

```bash
forge create src/CollectionNFT.sol:CollectionNFT --rpc-url http://localhost:8545
forge create src/CounterNFT.sol:CounterNFT --rpc-url http://localhost:8545
```

**Interacting with the Contracts**

To count prime NFTs owned by an address:

```solidity
ICollectionNFT collection = ICollectionNFT(<CollectionNFT_Address>);
CounterNFT counter = new CounterNFT();
uint256 primeCount = counter.getPrimeNFTsAmount(collection, <Owner_Address>);
```

To check if a specific number is prime:

```solidity
bool isPrime = counter.isPrime(<Number>);
```

**Contributing**

Contributions are welcome! Please fork the repository and open a pull request with your features or fixes.

**License**

This project is unlicensed and free for use by anyone.
