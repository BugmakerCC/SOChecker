pragma solidity ^0.8.9;
contract Test {
    mapping(uint16 => bool) public usedTokens;  
    uint16 public totalTokens = 40000;  
    
    function getRandomToken(uint16 player) public returns (uint16) {
        require(player > 0, "Invalid player ID");  
        
        uint16 tokenId = _generateRandomToken(player);  
        while (usedTokens[tokenId]) {  
            tokenId = _generateRandomToken(player);
        }
        
        usedTokens[tokenId] = true;  
        return tokenId;  
    }
    
    function _generateRandomToken(uint16 player) private view returns (uint16) {
        uint16 randomNumber = uint16(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, player))));
        return (randomNumber % totalTokens) + 1;  
    }
}


