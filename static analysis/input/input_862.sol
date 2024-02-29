interface IExchangeRate {
    function tinycentsToTinybars(uint256 tinycents) external returns (uint256);
    function tinybarsToTinycents(uint256 tinybars) external returns (uint256);
}

pragma solidity ^0.8.18;

interface IExchangeRate {
    function tinycentsToTinybars(uint256 tinycents) external returns (uint256);

    function tinybarsToTinycents(uint256 tinybars) external returns (uint256);
}

contract Exchange {
    IExchangeRate constant ExchangeRate =
        IExchangeRate(address(0x168));

    event ConversionResult(uint256 inAmount, uint256 outAmount);

    function convert(uint256 usdCents) external returns (uint256 hbarCents) {
        hbarCents = ExchangeRate.tinycentsToTinybars(usdCents * 100_000_000) / 1_000_000;
        emit ConversionResult(usdCents, hbarCents);
    }
}



