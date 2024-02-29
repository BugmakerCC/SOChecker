pragma solidity ^0.8.9;
contract DrugRegistry {
    struct Drug {
        string name;
        uint256 price;
    }

    Drug[] private drugs;
    uint256 private counter;

    function addDrug(string memory _name, uint256 _price) public {
        Drug memory newDrug = Drug({
            name: _name,
            price: _price
        });
        
        drugs.push(newDrug);
        counter++;
    }

    function getDrugs(string memory _name) public view returns (Drug[] memory) {
        Drug[] memory drugsToReturn = new Drug[](_getCount(_name));
        uint256 index = 0;

        for(uint i=0;i<counter;i++) {
            if (keccak256(abi.encodePacked((drugs[i].name))) == keccak256(abi.encodePacked((_name)))){
                drugsToReturn[index] = drugs[i];
                index++;
            }
        }
        
        return drugsToReturn;
    }

    function _getCount(string memory _name) private view returns (uint256) {
        uint256 count = 0;

        for(uint i=0;i<counter;i++) {
            if (keccak256(abi.encodePacked((drugs[i].name))) == keccak256(abi.encodePacked((_name)))){
                count++;
            }
        }

        return count;
    }
}

