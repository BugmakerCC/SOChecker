pragma solidity ^0.4.25;
contract AddressHash {
    
     function hashAddress(address _addr) public view returns(uint256) {
        uint256 hashAddr = uint256(keccak256(_addr));
        return hashAddr;
    }
    
     function hashAddressHex(address _addr) public view returns(uint256) {
        uint256 hashAddr = uint256(keccak256(_addr));
        return hashAddr;
    }
    
     function hashAddressShort(address _addr) public view returns(uint256) {
        uint256 hashAddr = uint256(keccak256(_addr));
        return hashAddr;
    }
    
}

