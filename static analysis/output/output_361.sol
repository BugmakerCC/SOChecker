pragma solidity ^0.8.9;
contract TransferTo {
    mapping(uint256 => address) IdToAddress;
    
    function transfer(address _recipient, uint256 _id) public {
        require(IdToAddress[_id] == msg.sender, "You're not the current token owner");
        IdToAddress[_id] = _recipient;
    }

}

