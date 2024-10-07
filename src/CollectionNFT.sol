// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ICollectionNFT} from "./ICollectionNFT.sol";

/// @title A Collection of NFTs based on ERC721
/// @notice This contract handles the creation and management of a fixed number of NFTs
/// @dev Inherits from ERC721 and ERC721Enumerable for NFT functionality
contract CollectionNFT is ERC721, ERC721Enumerable, ICollectionNFT {
    uint256 constant MAX_SUPPLY = 100;

    /// @notice Creates a new CollectionNFT contract, mints all NFTs to the deployer
    /// @param name_ The name of the NFT collection
    /// @param symbol_ The symbol of the NFT collection
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        uint256 max = MAX_SUPPLY + 1;

        for (uint256 i = 1; i < max; ++i) {
            _mint(msg.sender, i);
        }
    }

    /// @notice Checks if a given interfaceId is supported by the contract
    /// @dev Overrides ERC721 and ERC721Enumerable's supportsInterface method
    /// @param interfaceId The interface identifier, as specified in ERC-165
    /// @return True if the interface is supported, false otherwise
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    /// @notice Retrieves a list of tokenIds owned by a given address
    /// @param owner The address to query
    /// @return tokens An array of tokenIds owned by the address
    function getOwnerTokens(address owner) public view returns (uint256[] memory tokens) {
        uint256 tokenCount = balanceOf(owner);

        if (tokenCount == 0) {
            return new uint256[](0);
        }

        tokens = new uint256[](tokenCount);

        for (uint256 i = 0; i < tokenCount; ++i) {
            tokens[i] = tokenOfOwnerByIndex(owner, i);
        }
    }

    /// @dev Internal function to update token ownership, overridden to comply with multiple inheritance
    /// @param to The address receiving the token
    /// @param tokenId The token ID to transfer
    /// @param auth Additional authorization or validation logic
    /// @return The address that was authorized or involved in the update
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    /// @dev Internal function to increase the balance of an account, overridden to comply with multiple inheritance
    /// @param account The account whose balance will be increased
    /// @param value The amount by which to increase the balance
    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }
}
