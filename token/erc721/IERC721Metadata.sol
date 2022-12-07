// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./IERC721.sol";

contract IERC721Metadata is IERC721 {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    // Returns the Uniform Resource Identifier (URI) for `tokenId` token.
    function tokenURI(uint256 tokenId) external view returns (string memory);
    
}