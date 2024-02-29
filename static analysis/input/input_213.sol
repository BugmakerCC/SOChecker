pragma solidity 0.5.8;

interface ITokenDeposit {}

interface trcToken {}

contract CWC is ITokenDeposit {
  string public name = "Decentralized CWC";
  string public symbol = "CWC";
  uint8  public decimals = 18;
  trcToken  public usddTokenId = trcToken(1004777);
}


