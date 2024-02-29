pragma solidity ^0.8.9;
  abstract contract Context {

    
    function _msgSender() internal view virtual returns (address payable sender) {
      
      
      return payable(msg.sender);
    }
  
    function _msgData() internal virtual view returns (bytes memory) {
      
      
      return msg.data;
    }
  
  }

