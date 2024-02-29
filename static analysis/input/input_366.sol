contract Category is Post {
  function isCategoryExists(uint256 index) external view returns (bool) {
    if (categories[index].isExist) {
      return true;
    }
    return false;
  }
  createPost(){}
}


