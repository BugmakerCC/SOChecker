interface IERC20 {
   function transferFrom(address sender, address recipient, uint amount) external returns(bool);
}

contract Energy {
   address currentTokenAddress public = 0xTOKEN;
   mapping(address => uint) energyBalance;

   function sendToken_and_ConvertEnergys(uint _tokenAmount) external {
       uint calculatedEnergy = _tokenAmount/1000;
       IERC20(currentTokenAddress ).transferFrom(msg.sender,address(this),calculatedEnergy);
       energyBalance[msg.sender] += _calculatedEnergy;
  }
}


