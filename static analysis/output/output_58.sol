pragma solidity ^0.8.9;
contract InvestmentFactory {
    uint256 public investLength;
    event Invest(address investor, uint256 invested);
    
    struct Investment {
        address owner;
        uint256 amountInvested;
    }
    
    mapping (address => Investment[]) public investments;
        
    function invest(uint256 amount) public payable {
        uint256 id = investLength++;
        Investment memory investment;
        investment.owner = msg.sender;
        investment.amountInvested = amount;
        investments[msg.sender].push(investment);
        emit Invest(msg.sender, amount);
    }
}

