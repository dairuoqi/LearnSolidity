// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "../Token/erc721/IERC721.sol";

contract DutchAution is IERC721 {

    uint private constant DURATION = 7 days;
    IERC721 public immutable nft;
    uint public immutable nftId;
    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expireAt;
    uint public immutable discountRate;

    constructor(uint _startingPrice, uint _discountRate, address _nft, address _nftId) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expireAt = block.timestamp + DURATION;
        require(_startingPrice >= _discountRate * DURATION, "starting price < discount");
        nft = IERC721(_nft);
        nftId = _nftId;

    }
    
    function getPrice() public view returns (uint) {
        uint discount = discountRate * (block.timestamp - startAt);
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expireAt, "Auction Expired");
        uint price = getPrice();
        require(msg.value >= price, "ETH < price");
        nft.transferFrom(sell, msg.sender, nftId);
        uint refund = msg.value - price;
        if (refund) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
       
    }
}