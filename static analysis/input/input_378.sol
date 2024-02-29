contract Parent {
    uint256 public number; 
    uint256 internal otherNumber; 
    uint256 private anotherNumber; 
}
      
contract Child is Parent {
}


