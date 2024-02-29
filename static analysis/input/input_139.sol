uint256 public mintCost = 0.05 ether;

function setCost(uint256 _newCost) public onlyOwner {
        mintCost = _newCost;
 }


