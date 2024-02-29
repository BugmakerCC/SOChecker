pragma solidity ^0.8.9;
interface IERC20 {
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract Admin {
  address public admin;
  mapping (address => uint) public balance;

  constructor()  {
    admin = msg.sender;
    balance[admin] = 0;

}

  function depositMoneyToAdmin() payable public {
        (bool success,) = admin.call{value: msg.value}("");
        balance[admin]+=msg.value;
         require(success,"Transfer failed!");
    }

}

