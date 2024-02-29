pragma solidity ^0.8.9;
contract MyContract {

  string public svg; 

  function setSvg(string calldata svg_) external {
      svg = _svg;
  }

  
  string private constant _svg = "https://example.com/icon.svg";

}
