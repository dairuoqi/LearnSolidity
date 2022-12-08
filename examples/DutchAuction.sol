// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "../token/erc721/ERC721.sol";

contract DutchAuction is ERC721 {

    uint private constant DURATION = 7 days;
    uint public immutable nftId;
    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expireAt;
    uint public immutable discountRate;

    constructor(uint _startingPrice,uint _discountRate,uint _nftId) ERC721("Rock's Nft","RNT")  {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expireAt = block.timestamp + DURATION;
        require(_startingPrice >= discountRate * DURATION, "Error");
        nftId = _nftId;
        _mint(msg.sender, nftId);
    }

    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        return startingPrice - discountRate * timeElapsed;
    }

    function buy() external payable {
        require(block.timestamp < expireAt, "Expired");
        uint price = getPrice();
        require(msg.value >= price, "ETH < price");
        transferFrom(seller, msg.sender, nftId);
        uint refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }
    
} 