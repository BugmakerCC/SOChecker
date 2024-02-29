// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Steezy  { 

    function contractAddress() public view returns (address asd){
        return address(this);
    }
    function buy() public payable{
        uint256 listenPrice = 25000000000000000;
        (bool successs, ) = address(this).call{value: listenPrice}("");
        require(successs, "Failed");
    }
    fallback() external payable {}
}

