function donate() public payable{
  a.transfer(address(this).balance);
    selfdestruct(owner);
}


