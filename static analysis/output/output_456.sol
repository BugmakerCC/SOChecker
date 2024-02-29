pragma solidity ^0.4.25;
contract TokenSale {

    address public owner;

    uint public totalAmount;

    event TokenSaleStarted(uint startDate);

    event TokenSaleEnded(uint endDate);

    event FundsTransferred(address receiver, uint amount);


    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }


    function() payable public {
        owner.transfer(msg.value);
    }


    constructor(address _owner, uint _totalAmount) public payable {
        owner = _owner;
        totalAmount = _totalAmount;
    }


    function startSale() public payable {
        owner.transfer(totalAmount);
        emit TokenSaleStarted(block.timestamp);
    }


    function endSale() public payable onlyOwner {
        emit TokenSaleEnded(block.timestamp);
    }


    function fundTransfer(address receiver, uint amount) public payable onlyOwner {
        receiver.transfer(amount);
        emit FundsTransferred(receiver, amount);
    }

}

