pragma solidity ^0.8.0;

IMPORT "@openzeppelin/contracts/tokens/ERC20/IERC20.sol";


contract Testing{
    address public manager;
    IERC20 wETH;

    constructor(IERC20 _wETH){
         manager =msg.sender;
         wETH = _wETH;
    }

    function getMoneyFromManager(uint quantity) public payable{
        wETH.transferFrom(manager, msg.sender, quantity)
    }

}


