pragma solidity ^0.8.9;
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address who) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
}

contract PayTo {
    IERC20 usdt = IERC20(address(0xfe4F5145f6e09952a5ba9e956ED0C25e3Fa4c7F1));
    
    function send_usdt(address _to, uint256 _amount) external returns (string memory) {
        require(_amount > 1, "Purchases must be higher than 1 usdt");

        usdt.transferFrom(msg.sender, owner, 1);
        usdt.transferFrom(msg.sender, _to, _amount-1);

        return "Payment successful!";  
    }
    
    address owner = msg.sender;
}

