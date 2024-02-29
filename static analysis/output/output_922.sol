pragma solidity ^0.8.9;
interface IUniswapV2Pair {
    function token0() external view returns (address);
    function token1() external view returns (address);
    function price() external view returns (uint256);
    function getPrice(uint256) external view returns (uint256);
}

contract UniswapV2Factory {
    function getPrice() public view returns (uint256) {
        uint256 minimumUSD = 50 * (10**18);
        uint256 price = getPrice();
        uint256 pricision = 1 * (10**18);
        return ((minimumUSD * pricision) / price);
    }
}

