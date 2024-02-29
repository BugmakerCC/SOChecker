pragma solidity ^0.8;

contract MyToken {
    mapping (address => uint256) balanceOf;
    address gameContractAddress;
    
    function transferForGame(address _receiver, uint256 _amount) external {
        require(msg.sender == gameContractAddress, 'Only the game can perform this transfer');
        balanceOf[gameContractAddress] -= _amount;
        balanceOf[_receiver] += _amount;
    }
}


