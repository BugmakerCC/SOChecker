pragma solidity ^0.6.0;

import "./ERC721.sol";

contract Mytoken is ERC721 {
    string constant name = "MyToken";
    string constant symbol = "MTKN";

    constructor() ERC721(name, symbol) {
        
    }

}


