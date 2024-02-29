pragma solidity ^0.8.9;
contract TestToken {
    function _transfer(address sender,address recipient, uint256 amount) private returns(bool){
    require(recipient != address(0),"ERC20: transfer to the zero address");
    uint256 senderBalances = balanceOf[sender];
    require(senderBalances >= amount,"You don't have enough token");
    balanceOf[sender] = senderBalances - amount;
    balanceOf[recipient] += amount;

    return true;
}


mapping (address => uint256) public balanceOf;


event Transfer(address indexed from, address indexed to, uint256 value);


 constructor() public {
    balanceOf[msg.sender] = 100000000000000000;
}

function transfer(address recipient,uint256 amount) public returns (bool) {
    _transfer(msg.sender,recipient,amount);
}




}

