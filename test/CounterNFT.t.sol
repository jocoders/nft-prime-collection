// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {CounterNFT} from "../src/CounterNFT.sol";
import {CollectionNFT} from "../src/CollectionNFT.sol";
import {TestERC721Receiver} from "./TestERC721Receiver.sol";

contract CounterTest is Test {
    uint256 constant MAX_SUPPLY = 100;

    CounterNFT public counter;
    CollectionNFT public collection;
    TestERC721Receiver public alice;
    TestERC721Receiver public bob;

    function setUp() public {
        collection = new CollectionNFT("TestToken", "TT");
        counter = new CounterNFT();
        alice = new TestERC721Receiver();
        bob = new TestERC721Receiver();
    }

    function testTotalSupply() public view {
        assertEq(collection.totalSupply(), MAX_SUPPLY, "Total supply should be 100 tokens.");
    }

    function testTokenIDs() public view {
        uint256 firstTokenId = collection.tokenByIndex(0);
        uint256 lastTokenId = collection.tokenByIndex(collection.totalSupply() - 1);

        assertEq(firstTokenId, 1, "The first token ID should be 1");
        assertEq(lastTokenId, 100, "The last token ID should be 100.");
    }

    function testGetOwnerTokensAliceOneToken() public {
        collection.safeTransferFrom(address(this), address(alice), 4);

        uint256[] memory aliceTokens = collection.getOwnerTokens(address(alice));

        assertEq(collection.ownerOf(4), address(alice), "Alice should have token 4");
        assertEq(aliceTokens.length, 1, "Alice should have 1 tokens");
    }

    function testGetOwnerTokensAlice() public {
        collection.safeTransferFrom(address(this), address(alice), 1);
        collection.safeTransferFrom(address(this), address(alice), 2);
        collection.safeTransferFrom(address(this), address(alice), 3);
        collection.safeTransferFrom(address(this), address(alice), 4);

        uint256[] memory aliceTokens = collection.getOwnerTokens(address(alice));

        assertEq(collection.ownerOf(1), address(alice), "Alice should have token 1");
        assertEq(collection.ownerOf(4), address(alice), "Alice should have token 4");
        assertEq(aliceTokens.length, 4, "Alice should have 4 tokens");
    }

    function testGetOwnerTokensBob() public {
        uint256 tokensAmount = MAX_SUPPLY / 2;

        for (uint256 i = 1; i <= tokensAmount; i++) {
            collection.safeTransferFrom(address(this), address(bob), i);
        }

        uint256[] memory bobTokens = collection.getOwnerTokens(address(bob));

        assertEq(collection.ownerOf(1), address(bob), "Alice should have token 1");
        assertEq(collection.ownerOf(tokensAmount), address(bob), "Alice should have token 250");
        assertEq(bobTokens.length, tokensAmount, "Alice should have 4 tokens");
    }

    function testGetPrimeNFTsAmountAlice() public {
        collection.safeTransferFrom(address(this), address(alice), 3);
        uint256 primeNFTsAmount = counter.getPrimeNFTsAmount(collection, address(alice));
        assertEq(primeNFTsAmount, 1, "Alice should have 1 prime NFTs");
    }

    function testGetPrimeNFTsAmountBob() public {
        collection.safeTransferFrom(address(this), address(bob), 1);
        collection.safeTransferFrom(address(this), address(bob), 2);
        collection.safeTransferFrom(address(this), address(bob), 3);
        collection.safeTransferFrom(address(this), address(bob), 4);
        collection.safeTransferFrom(address(this), address(bob), 5);
        collection.safeTransferFrom(address(this), address(bob), 6);
        collection.safeTransferFrom(address(this), address(bob), 7);
        collection.safeTransferFrom(address(this), address(bob), 8);
        collection.safeTransferFrom(address(this), address(bob), 9);

        uint256 primeNFTsAmount = counter.getPrimeNFTsAmount(collection, address(bob));
        assertEq(primeNFTsAmount, 4, "Bob should have 4 prime NFTs");
    }

    function testGetPrimeNFTsAmountAliceOnePrime() public {
        collection.safeTransferFrom(address(this), address(alice), 8);
        collection.safeTransferFrom(address(this), address(alice), 9);

        uint256 primeNFTsAmount = counter.getPrimeNFTsAmount(collection, address(alice));
        assertEq(primeNFTsAmount, 0, "Alice should have 0 prime NFTs");
    }

    function testGetPrimeNFTsAmountBobOnePrime() public {
        collection.safeTransferFrom(address(this), address(bob), 59);

        uint256 primeNFTsAmount = counter.getPrimeNFTsAmount(collection, address(bob));
        assertEq(primeNFTsAmount, 1, "Bob should have 1 prime NFTs");
    }
}
