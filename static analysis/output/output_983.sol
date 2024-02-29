pragma solidity ^0.8.9;
interface IERC20 {
    function deposit(address ticker,address sender,address recipient,uint256 amount
                ) 
                external payable
               
                returns(bytes memory)
                ;
}

