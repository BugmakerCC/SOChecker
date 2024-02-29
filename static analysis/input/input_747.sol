
pragma solidity >=0.5.0 <0.9.0;

import "./SimpleStorage.sol"; 
contract StorageFactory{
    
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public 
    {
        SimpleStorage simpleStorageContract = new SimpleStorage();
        simpleStorageArray.push(simpleStorageContract);
    }

     function sfStore(uint256 _simpleStorrageIndex, uint256 _simpleStorageNumber) public
     {
       SimpleStorage simpleStorageContract =  SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])); 
       simpleStorageContract.store(_simpleStorageNumber);   
     }
}

pragma solidity >=0.7.0 <0.9.0;

contract Answer
{
    mapping(address => uint) public StorageMap; 

    function InsertToStorage(address name, uint favoritenumber) public 
    {
        StorageMap[name] = favoritenumber;
    }

    function GetFavoriteNumber(address name) public view returns(uint) 
    {
        return StorageMap[name];
    }
}


