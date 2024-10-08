// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ICollectionNFT} from "./ICollectionNFT.sol";

/// @title Counter for Prime Number NFTs
/// @notice This contract provides utility functions to count prime number NFTs owned by a user
/// @dev This contract interacts with an NFT collection and checks for prime numbered tokens
contract CounterNFT {
    /// @notice Counts the number of prime-numbered NFTs owned by a specific address
    /// @dev Iterates through token IDs owned by the user and checks each for primality
    /// @param collectionNFT The address of the NFT collection contract
    /// @param owner The address of the token owner
    /// @return count The number of prime-numbered NFTs owned by the user
    function getPrimeNFTsAmount(ICollectionNFT collectionNFT, address owner) external view returns (uint256 count) {
        uint256[] memory ownerTokens = collectionNFT.getOwnerTokens(owner);
        uint256 length = ownerTokens.length;

        for (uint256 i = 0; i < length; ++i) {
            if (isPrime(ownerTokens[i])) {
                ++count;
            }
        }
    }

    /// @notice Determines if a number is prime
    /// @dev Checks primality by testing divisibility from 2 up to the square root of the number
    /// @param number The number to check
    /// @return True if the number is prime, false otherwise
    function isPrime(uint256 number) public pure returns (bool) {
        if (number < 2) return false;
        if (number == 2 || number == 3) return true; // Directly return true for 2 and 3
        if (number % 2 == 0) return false; // Check if number is even

        uint256 sqrtNum = sqrt(number); // Calculate square root once
        for (uint256 i = 3; i <= sqrtNum; i += 2) {
            if (number % i == 0) return false;
        }
        return true;
    }

    /// @notice Calculates the integer square root of a given number using the Babylonian method.
    /// @dev This function uses an iterative approach to approximate the square root.
    /// @param x The number to calculate the square root of.
    /// @return y The approximate integer square root of the given number.
    function sqrt(uint256 x) internal pure returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}
