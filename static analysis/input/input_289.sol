pragma solidity ^0.8.16;
 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MyT") {
        _mint(msg.sender, 1000 * 1e18);
    }

    function _afterTokenTransfer(address from, address to, uint256 amount) internal override {
        if (to.code.length > 0) {
            try IERC20Receiver(to).onERC20Receive(from, amount) returns (bool success) {
            } catch {
            }
        }
    }
}

interface IERC20Receiver {
    function onERC20Receive(address from, uint256 amount) external returns (bool);
}

contract SomeReceiver is IERC20Receiver {
    event ReceivedTokens(address from, uint256 amount);

    function onERC20Receive(address from, uint256 amount) external returns (bool) {
        emit ReceivedTokens(from, amount);
        return true;
    }
}


