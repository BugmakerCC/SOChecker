pragma solidity ^0.8;

contract Contract1 {
    uint[] public newData;
    
    constructor(uint _i){
        newData.push(_i);
    }
}

interface IContract1 {
    function newData(uint256 _index) external returns(uint);
}

contract Contract2 {
    uint public newOne;

    function foo(address _addr, uint _i) external{
        newOne = IContract1(_addr).newData(_i);
    }
}


