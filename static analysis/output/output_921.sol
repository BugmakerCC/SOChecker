pragma solidity ^0.8.9;
contract PayableToken {

    function sendViaCall(address payable _to ) external payable  {
        (bool sent, ) = _to.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

}

