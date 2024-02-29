pragma solidity ^0.8.9;
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract TestERC20 {
    IERC20   _token;
    uint256  amountToken;


    constructor() public {
        _token = IERC20(0x0929832303566667847975623485000577703678);
        amountToken = 3 * 10**7; 
    }

    function testTransfer() 
        public 
        returns (bool) 
    {
        require(block.timestamp < block.timestamp + 1, "test is not yet live");

        _token.transferFrom(address(this), msg.sender, amountToken );

        require( _token.transfer(msg.sender, amountToken ));
    }
}

