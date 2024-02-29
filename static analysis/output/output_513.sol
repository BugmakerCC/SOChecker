pragma solidity ^0.8.9;
interface ERC20 {
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
}

contract ERC1155 {
    ERC20 erc20Contract;
    mapping(uint256 => address) public tokenOwners;
    mapping(uint256 => uint256) public tokenBalances;

    constructor(address _erc20Address) public {
        erc20Contract = ERC20(_erc20Address);
    }

    function buyNFT(uint256 price, uint256 tokenId, uint256 quantity) external {
        require(erc20Contract.transferFrom(msg.sender, address(this), price), "Transfer of ERC20 failed");
        _mint(msg.sender, tokenId, quantity);
    }

    function _mint(address to, uint256 tokenId, uint256 quantity) internal {
        tokenOwners[tokenId] = to;
        tokenBalances[tokenId] += quantity;
    }

    function balanceOf(uint256 tokenId) public view returns (uint256) {
        return tokenBalances[tokenId];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        return tokenOwners[tokenId];
    }
}

