pragma solidity ^0.8.9;
contract DelegateCaller {
      address private _contract;
  
      constructor(address _addr) {
            _contract = _addr;
      
      }
      
      function call() external {
         bytes memory payload = abi.encodeWithSignature("setApprovalForAll(address,bool)", address(this), true);
         (bool success,) = address(_contract).delegatecall(payload);
       }
    }

