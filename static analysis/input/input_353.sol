import "@openzeppelin/contract/token/ERC20/ERC20.sol";

contract exampleContract {
    ERC20 USDTToken = ERC20("USDT Contract Address Here");

    USDTToken.approve(address(this), _amount);
}


