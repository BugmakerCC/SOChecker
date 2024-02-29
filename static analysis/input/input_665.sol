function myFunction(address admin) external view returns (bool) {
   return adminMembers[address]._isDeleted;
}


