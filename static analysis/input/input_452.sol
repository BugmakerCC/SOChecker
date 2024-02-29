pragma solidity 0.8.16 ;
 contract arr
 {     uint256[4] public n ;
       uint256 x = 0 ;

  function pl(uint256 a ) public
    {
      n[x] = a ;
      x++ ;
     }
 }

pragma solidity 0.8.16 ;
 contract arr
 {     uint256[] public n ;
       uint256 x = 0 ;

  function pl(uint256 a ) public
    {
      n.push();
      n[x] = a ;
      x++ ;
     }
 }


