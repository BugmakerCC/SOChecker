pragma solidity ^0.8.9;
contract holderlist {

    address[] public holderlist;

    constructor() public {

holderlist[0] = msg.sender;

holderlist.push(msg.sender);

}


    receive() external payable {
    }
    function addholder(address _holder)public {
    holderlist.push(_holder);
    }
}

