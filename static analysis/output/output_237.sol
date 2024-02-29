pragma solidity ^0.8.9;
interface IPolyMath {
    function add( uint256 a, uint256 b ) external view returns (uint256);
    function sub( uint256 a, uint256 b ) external view returns (uint256);
    function mul( uint256 a, uint256 b ) external view returns (uint256);
}

