struct Data {
    uint256 number;
    uint256 balance;
}

...

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


