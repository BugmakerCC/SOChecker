pragma solidity ^0.8.9;
contract PhoneRegistry {
    // Define a structure to store phone data
    struct Data {
        uint256 number;
        uint256 balance;
    }

    // Define a mapping to associate an owner (address) with his phones (array of uint256)
    mapping(address => uint256[]) public phones;

    // Define a mapping to associate a phone number (uint256) with its balance (uint256)
    mapping(uint256 => uint256) public balance;

    // Function to get the details of all phones of a specific owner
    function details(address owner) public view returns (Data[] memory data) {
        uint256[] memory ownerPhones = phones[owner];
        uint256 numPhones = ownerPhones.length;
        data = new Data[](numPhones);

        uint256 number;

        for (uint256 i = 0; i < numPhones; i++) {
            number = ownerPhones[i];
            data[i].number = number;
            data[i].balance = balance[number];
        }
    }

    // Function to add a new phone for an owner
    function addPhone(address owner, uint256 number, uint256 _balance) public {
        phones[owner].push(number);
        balance[number] = _balance;
    }
}

