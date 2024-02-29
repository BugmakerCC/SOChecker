pragma solidity ^0.8.9;
contract CryptoFundsAddition {

  event FundsAdded(
    uint256 id,
    uint96 amount
  );

  function addFunds(
    uint256 id,
    uint96 amount
  ) public {
    emit FundsAdded(id, amount);
  }

}

