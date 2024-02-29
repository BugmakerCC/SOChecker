YourTokenStruct[] public yourTokens;

struct YourTokenStruct {
    string name;
    uint256 id;
}

function mint(string memory name, uint256 id) public payable returns(uint256){
    require(msg.value == 1 ether);
    require(id > 0);
    
    uint _tokenId = yourTokens.push(YourTokenStruct(name, id)) - 1;

    _mint(msg.sender, _tokenId);

    return _tokenId;
}

function withdraw() payable external ifOwner {
    msg.sender.transfer(address(this).balance);
}


