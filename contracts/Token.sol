//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Token is ERC721 {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        for (uint256 i = 0; i <= 5; i++) {
            _safeMint(msg.sender, 20 + i);
        }
    }
}
