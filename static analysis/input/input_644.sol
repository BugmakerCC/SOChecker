pragma solidity 0.8.15;

import "./MainContract.sol";

contract Logger {  
   address private owner;
   MainContract mainContract;
   constructor(address _mainContract){
       owner = msg.sender;
       mainContract = new MainContract(_mainContract);
   }
   function log(address _caller, uint _amount, string memory _action, uint256 value) public {
        if (equal(_action, "withdraw")) {
        }
        else if (_caller == owner){
            mainContract.action(value);
        }
    }

    function equal(string memory _a, string memory _b) public pure returns (bool) {
        return keccak256(abi.encode(_a)) == keccak256(abi.encode(_b));
    }
}


