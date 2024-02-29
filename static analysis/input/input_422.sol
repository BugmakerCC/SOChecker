pragma solidity ^0.8.7;

struct UserInfo{
   uint id ;
   string ime;
}

interface IContract1{    
    function arr(uint index) external returns(UserInfo memory );
}

contract Contract2{
    event UserEVENT (UserInfo UserInfo);
    UserInfo [] public newarr;

    function foo(address addr,uint i) external {
        IContract1(addr).arr(i);
        emit UserEVENT (IContract1(addr).arr(i));
    }
}


