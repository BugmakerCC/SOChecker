   address public  owner;

  constructor()

 function transferOwnership(address newOwner) public onlyOwner{

constructor (string memory tokenName, string memory tokenSymbol, uint initialSupply) {

  function _transfer(address _from,address _to,uint256 _value ) internal {
    require(_to != 0x0000000000000000000000000000000000000000);

function mintToken (address _target, uint256 _mintedAmount) public onlyOwner {
        balanceOf[_target] += _mintedAmount;
        totalSupply += _mintedAmount;
        emit Transfer(address(0), owner, _mintedAmount);
        emit Transfer(owner, _target, _mintedAmount);
    }


