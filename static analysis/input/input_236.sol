pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Test is Ownable {

    function heresHowYouUseIt() public onlyOwner {
    }
}


