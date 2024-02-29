pragma solidity ^0.8.9;
interface ProxyRegistrar {
    function registerProxy(bytes4 interfaceId) external;

    function unregisterProxy(bytes4 interfaceId) external;

    function proxies(address owner) external view returns (address[] memory);
}

