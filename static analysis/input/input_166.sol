constructor(address _contractAddress) {
    new = contractA(_contractAddress);
    owner = new.owner();
}

 function setOwnership(address newOwner) private {
        owner = payable(newOwner);
    } 

function set_data(string memory _data) public {
    owner=setOwnership(msg.sender);
    require(owner == msg.sender,"You are not the owner of the contract");
    data = _data;
    blocknumber = block.number;
}

mapping(address => bool) private whiteList;


