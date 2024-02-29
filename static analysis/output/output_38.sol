pragma solidity ^0.8.9;
interface MaticBridge {
    function deposit(address _token, uint256 _amount) external returns (uint256);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
}

contract matic_farm {
    address public maticFarmAddress = 0x24920E62B2702c11011823E64387B8AB46C1c927; 
    MaticBridge private bridge;

    constructor() public {
        bridge = MaticBridge(maticFarmAddress);
    }

    function deposit(address _token, uint256 _amount) external payable {
        uint256 tokens = IERC20(_token).balanceOf(address(this));
        require(tokens == 0, "Already deposited");
        bridge.deposit(_token, _amount);
    }

    receive() external payable {}
}

