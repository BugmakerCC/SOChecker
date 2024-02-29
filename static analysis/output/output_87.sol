pragma solidity ^0.8.9;
contract SimpleStorageArrayExample {

    SimpleStorage[] public simpleStorageArray; 

    function createSimpleStorageContract() public {
    SimpleStorage simpleStorage = new SimpleStorage();
    simpleStorageArray.push(simpleStorage);

    }  
   
}

contract SimpleStorage {
    function addValue() public { 
    uint256 storageValue = 5028135561;
    emit Log_value_added(storageValue);}
    function subtractValue() public {
    uint256 storageValue = 5028135561;
    emit Log_value_subtracted(storageValue);}
    event Log_value_added(uint256 _value_added);
    event Log_value_subtracted(uint256 _value_subtracted);
}

