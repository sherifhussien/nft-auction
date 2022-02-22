//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Auction is Ownable {
    IERC721 token;
    uint256 tokenId;

    bool started;
    bool ended;
    uint256 endAt;

    uint256 highestBid;
    address highestBidder;
    address payable public seller;
    mapping(address => uint256) public bids;

    constructor(
        address _token,
        uint256 _tokenId,
        uint256 _initialBid
    ) {
        seller = payable(msg.sender);
        token = IERC721(_token);
        tokenId = _tokenId;
        highestBid = _initialBid;
    }

    function start() external onlyOwner {
        require(!started, "Auction already started!");

        started = true;
        endAt = block.timestamp + 5 days;

        token.transferFrom(msg.sender, address(this), tokenId);
    }

    function bid() external payable {
        require(started, "Not started!");
        require(block.timestamp < endAt, "Ended!");
        require(msg.value > highestBid, "value < highest");
        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdraw() external {
        uint256 balance = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

    function end() external {
        require(started, "Not started!");
        require(!ended, "Ended!");
        require(block.timestamp >= endAt, "Not ended!");

        ended = true;

        if (highestBidder != address(0)) {
            token.transferFrom(address(this), highestBidder, tokenId);
            seller.transfer(highestBid);
        } else {
            // return bidded token to seller
            token.transferFrom(address(this), seller, tokenId);
        }
    }
}
