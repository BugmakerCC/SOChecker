pragma solidity ^0.8.9;
contract RandomNumberGen {

    function random() view public returns (uint)
    {

        uint answer = block.timestamp% 10 ;

        return answer;
    }
}

