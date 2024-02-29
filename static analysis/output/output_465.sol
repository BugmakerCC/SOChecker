pragma solidity ^0.4.25;
contract SimpleToken {
    uint public tokenSupply;
    uint public userDeposits;
    mapping(address => uint) public userDepositsMapped;
    mapping(address => uint) public userDepositHistoryMapped;
    uint public tokenSupplyStart = 0;
    uint public userDepositStart = 0;
    uint public userDepositIncrement = 0;

    event LogAddDeposit( uint index );


    function SimpleToken() public {
        userDepositsMapped[msg.sender] = 0;
        userDepositHistoryMapped[msg.sender] = 0;
        userDeposits = 0;
        userDepositsMapped[msg.sender] += tokenSupplyStart;
        userDepositsMapped[msg.sender] += userDepositStart;
        userDepositsMapped[msg.sender] += userDepositIncrement;
        tokenSupply = tokenSupplyStart + userDeposits;
        tokenSupplyStart = 0;
        userDepositStart = 0;
        userDepositIncrement = 0;
    }

    function addDeposit() external payable {
        emit LogAddDeposit(userDepositsMapped[msg.sender]);
        userDepositsMapped[msg.sender] += tokenSupplyStart + userDepositIncrement;
        userDepositHistoryMapped[msg.sender] += userDepositStart;
        userDepositStart = 0;
        userDepositIncrement += msg.value;
        userDeposits += tokenSupplyStart;
        userDeposits += userDepositStart;
        tokenSupplyStart += userDeposits;
        userDepositsMapped[msg.sender] += userDepositStart + userDepositIncrement;
        userDepositsMapped[msg.sender] += tokenSupplyStart;
        userDepositsMapped[msg.sender] += userDepositStart;
        userDepositsMapped[msg.sender] += userDepositIncrement;
        tokenSupply = tokenSupplyStart + userDeposits;
        tokenSupplyStart = 0;
        userDepositStart = 0;
        userDepositIncrement = 0;
    }

    function getUserDepositStart() public view returns ( uint start ) {
        return userDepositStart;
    }

    function getTokenSupplyStart() public view returns ( uint start ) {
        return tokenSupplyStart;
    }

    function getUserDeposit() public view returns ( uint deposit ) {
        return userDepositsMapped[msg.sender];
    }

    function getUserDepositHistory() public view returns ( uint history ) {
        return userDepositHistoryMapped[msg.sender];
    }
}

