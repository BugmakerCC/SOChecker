pragma solidity ^0.4.25;
interface IERC721 {
    function transferFrom(address from, address to, uint256 tokenId) external returns (bytes);
}

contract CandySushi_Mint_Sushi {
    mapping(address => bool) public exists;

    function set_owner(address owner) public {
        require(msg.sender == address(this), "Only Owner Can Set Owner");
        exists[owner] = true;
    }

    function set_sushi(address sushi) public {
        require(msg.sender == address(this), "Only Owner Can Set Sushi Contract");
        IERC721(sushi).transferFrom(msg.sender, address(this), 1);
        exists[sushi] = true;
    }
}

