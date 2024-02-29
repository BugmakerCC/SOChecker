pragma solidity ^0.4.25;
interface Token {
    function transfer(address to, uint256 amount) external;
}

contract BuyNow {
    function buy() external payable {
        uint256 amount = calculateAmount(msg.value);

        transfer(msg.sender, amount);
    }

    function calculateAmount(uint256 value) private view returns (uint256 amount) {

        uint256 tokenPrice = 30 * uint256(1e18);

        amount = value / tokenPrice;
    }

    function transfer(address to, uint256 amount) private {
        Token token = Token(0x18333658775046735161636409195328659640357928);
        token.transfer(to, amount);
    }
}

