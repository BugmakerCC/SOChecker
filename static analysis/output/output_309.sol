pragma solidity ^0.8.9;
interface Reentrance {
   function withdaw(uint256) external payable;
}

interface IERC1669 {
    function withdraw(uint amount) external;
}

