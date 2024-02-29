pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GameToken is ERC20 {
    address private gameBackend;

    constructor(address _gameBackend) ERC20("Game Token", "GT") {
        gameBackend = _gameBackend;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == gameBackend, "Only game backend can mint tokens");
        _mint(to, amount);
    }
}

async function swapOffchainToOnchainTokens(userAddress, swapAmount) {

     the user
    const gameTokenContract = new web3.eth.Contract(GameTokenABI, 
    GameTokenAddress);
    await gameTokenContract.methods.mint(userAddress, 
    swapAmount).send({ from: gameBackendAddress });
 }

 function mint(address to, uint256 amount) external {
    require(msg.sender == gameBackend, "Only game backend can mint 
    tokens");
    _mint(to, amount);
 }


