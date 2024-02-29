pragma solidity ^0.8.7;

contract Timer{
    
    uint256 public initialSupply = 1000 * (10 ** 18);
    uint256 public ts_end;
    address public wallet = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public owner;
    bool public claimed;
    mapping (address => uint256) public balances;

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    constructor() {
        owner = msg.sender;
        balances[wallet] = initialSupply;
        ts_end = block.timestamp + (86400 * 30 * 12);
        
    }

    function claim() public onlyOwner {
        require(ts_end > block.timestamp,"Can not claim yet");
        require(claimed = false,"Already claimed");
        claimed = true;

        for(uint i = 0 ; i < 12 ; i++) {
            initialSupply += (initialSupply * 15) / 100;
        }
        balances[wallet] = initialSupply;
    }

    function balanceOf() external view returns(uint256) {
        return balances[msg.sender];
    }

}


