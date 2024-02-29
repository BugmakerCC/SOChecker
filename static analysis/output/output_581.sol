pragma solidity ^0.8.9;
interface IChainlinkClient {
    function sendChainlinkRequestTo( address oracle, bytes calldata request, uint256 fee) external;
}

