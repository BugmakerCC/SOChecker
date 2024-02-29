pragma solidity ^0.8;

contract Contract1 {
    // changed visibility to `public`
    uint[] public newData;
    
    constructor(uint _i){
        newData.push(_i);
    }
}

interface IContract1 {
    // added `_index` argument
    // changed the return value to one item of the array
    function newData(uint256 _index) external returns(uint);
}

contract Contract2 {
    uint public newOne;

    function foo(address _addr, uint _i) external{
        // changed the call to the getter function
        // instead of trying to access the property directly
        newOne = IContract1(_addr).newData(_i);
    }
}

