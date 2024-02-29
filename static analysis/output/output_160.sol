pragma solidity ^0.8.9;
contract Escrow {

address owner;

struct Deposit {
    uint256 depositAmount;
    address buyer;
    address seller;
}

constructor() payable {
owner = msg.sender;
}

mapping(bytes32 => Deposit) public depositByHash; 

event DepositMade(address depositor, uint depositAmount, bytes32 hash);

function deposit(address _seller) public payable returns(bytes32) {

    require(msg.value > 0, "error"); 

    bytes32 hash = keccak256(abi.encode(msg.value, block.timestamp, _seller)); 

    Deposit storage _deposit = depositByHash[hash]; 

    _deposit.depositAmount = msg.value; 

    _deposit.buyer = msg.sender;
    
    _deposit.seller = _seller;  

    emit DepositMade(msg.sender, msg.value, hash);

    return hash; 
}

function releaseDeposit(bytes32 hash) public {

    require (msg.sender == depositByHash[hash].buyer, "Only maker of the deposit can release deposit.");

    payable(depositByHash[hash].seller).transfer(depositByHash[hash].depositAmount);
}
}

