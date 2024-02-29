function getResult() public onlyOwner {
    luckyPerson.transfer(address(this).balance);
    lotteryId++;
    delete lotChances;
}

pragma solidity 0.8.7;
    
contract Lottery {
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    struct LotChance {
        address payable userAddress;
        uint256 ids;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "You aren't smart contract owner!");
        _;
    }
    
    LotChance[] public lotChances;
    
    function getResult(address _luckyPerson) public onlyOwner {
        uint lotteryId = 0;
        payable(_luckyPerson).transfer(address(this).balance);
        lotteryId++;
        delete lotChances;
    }
    
    function partecipateToLottery(uint _id) public {
        lotChances.push(LotChance(payable(msg.sender), _id));
    }
    
    function getLengthArray() external view returns(uint) {
        return lotChances.length;
    } 
}


