 import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";

 address poolAddress = IUniswapV3Factory(_factory).getPool(
        _token0,
        _token1,
        _fee
    );

mapping(address => mapping(address => mapping(uint24 => address))) public override getPool;

require(poolAddress!=address(0))


