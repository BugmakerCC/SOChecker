
contract minter{

  mapping(address => bool) public whiteList;

  function whiteLister( address _user) public{
    whiteList[_user] = true;   

}


