pragma solidity ^0.8.16;
 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
 
contract MyVault is IERC721Receiver {
    IERC20 immutable public erc20Token;
    IERC721 immutable public erc721Collection;

    uint256 constant public AMOUNT_OF_ERC20_PER_ERC721 = 1 * 1e18; 

    constructor(IERC20 _erc20Token, IERC721 _erc721Collection) {
        erc20Token = _erc20Token;
        erc721Collection = _erc721Collection;
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4) {

        bool success = erc20Token.transfer(_operator, AMOUNT_OF_ERC20_PER_ERC721);
        require(success);

        return this.onERC721Received.selector;
    }

    function erc20toErc721() external {
        bool success = erc20Token.transferFrom(msg.sender, address(this), AMOUNT_OF_ERC20_PER_ERC721);
        require(success);

        uint256 tokenId = 1;

        erc721Collection.safeTransferFrom(address(this), msg.sender, tokenId);
    }
}


