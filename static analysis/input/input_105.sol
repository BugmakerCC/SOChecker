modifier onlyOwner() {
   require(isOwner());
   _;
}

modifier onlyOwner() {
   _;
   require(isOwner());
}


