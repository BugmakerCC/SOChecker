pragma solidity ^0.8.9;
interface IPolyMath {
    function add( uint256 x, uint256 y ) external pure returns ( uint256 z );
    function mul( uint256 x, uint256 y ) external pure returns ( uint256 z );
}

