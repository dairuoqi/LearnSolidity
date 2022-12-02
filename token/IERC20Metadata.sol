// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./IERC20.sol";


interface IERC20Metadata is IERC20 {

    // Optional - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
    function name() external  view returns (string memory);

    // OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
    function symbol() external  view returns (string memory);

    // Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.
    // OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
    function decimals() external  view returns (uint8);
}