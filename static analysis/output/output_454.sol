pragma solidity ^0.4.25;
interface IERC20 {
  function totalSupply() external view returns (uint256);

  function balanceOf(address account) external view returns (uint256);

  function transfer(address recipient, uint256 amount) external returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);
}

interface AggregatorV3Interface {
  function latestRoundData() external view returns (uint256, uint256, uint256);
}

contract Asset {
  string internal description;
  uint256 internal price;
  uint256 internal shares;

  function Asset(address owner, string memory _description, uint256 _price, uint256 _shares)
    public {
    price = _price;
    shares = _shares;
    description = _description;
  }
}

