// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "../token/erc721/ERC721.sol";

contract EnglishAuction is ERC721 {
    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address highestBidder, uint amount);

    uint public immutable nftId;
    address payable public immutable seller;
    uint32 public endAt;
    bool public started;
    bool public ended;
    // 最高出价者
    address public highestBidder;
    // 最高出价   
    uint public highestBid;
    // 记录每一个出价者的出价
    mapping(address => uint) public bids;

    constructor(uint _nftId, uint _startingBid) ERC721 ("EnglishAuction", "EA") {
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller, "Not Seller");
        require(!started, "started");
        started = true;
        endAt = uint32(block.timestamp + 60);
        transferFrom(seller, address(this), nftId);
        emit Start();
    }

    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest bid");
        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(msg.sender,msg.value);
    }

    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt);
        ended = true;
        if (highestBidder != address(0)) {
            transferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            transferFrom(address(this),seller, nftId);
        }
        emit End(highestBidder, highestBid);
    }
}