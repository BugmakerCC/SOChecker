pragma solidity ^0.8.9;
contract LockETHPayable {

    mapping(address => uint256) lockAmounts;

    uint constant ethPrice = 2000;

    uint public constant deadline = 1659744400;

    function withdraw() public payable {    
        address recipient = msg.sender;
        uint256 additionalToken;

        if (ethPrice <= 2000) {    
            additionalToken = lockAmounts[msg.sender] * 2;
        }

        require(block.timestamp >= deadline);
        uint256 amountToWithdraw = lockAmounts[msg.sender] + additionalToken;
        lockAmounts[msg.sender] = 0; 
        (bool success, ) = payable(recipient).call{value: amountToWithdraw}("");
        require(success, "Transfer failed."); 
    }

}

