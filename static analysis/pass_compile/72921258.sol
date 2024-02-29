contract Parent {
    uint256 public number; // Child can write, others can only read
    uint256 internal otherNumber; // Child can write, others cannot read
    uint256 private anotherNumber; // no other contract can read
}
      
contract Child is Parent {
}

