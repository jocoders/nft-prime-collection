// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract TestERC721Receiver is IERC721Receiver {
    function onERC721Received(
        address, // operator не используется
        address, // from не используется
        uint256, // tokenId не используется
        bytes memory // data не используется
    ) public pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
