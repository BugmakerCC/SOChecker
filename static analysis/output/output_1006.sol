pragma solidity ^0.8.9;
contract SharesCalculator {
    string public name;
    address public owner;
    uint public pool;
    uint public totalShares;
    uint private _amount;
    uint private currentShares;

    constructor(string memory _name, address _owner) {
        name = _name;
        owner = _owner;
        totalShares = 0;
        pool = 0;
    }

    function getShares(uint _amount) public payable returns(uint) {
        pool = totalShares * 10 / 100;
         _amount = _amount * (totalShares) / 100;
            if (_amount < pool) {
                currentShares = (_amount * (totalShares)) / (pool);
            } else {
                currentShares = (_amount * (totalShares)) / (pool);
            }
        uint current = currentShares - 1;
        totalShares *= 100;
        totalShares = _amount;
        currentShares = current;
        return current;
    }

}

