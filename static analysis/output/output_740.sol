pragma solidity ^0.8.9;
contract RegularPost {
    struct RegularPost {
        uint256 category;
        string name;
        string post;
        address addr;
        uint256 date;
    }
    
    RegularPost[] public RegularPostArray;
    
    function updatePost(uint256 _postIndex, uint256 _newCategory) external {
      RegularPost storage post = RegularPostArray[_postIndex];
      post.category = _newCategory;
    }
    
    function notUpdatePost(uint256 _postIndex, uint256 _newCategory) external {
      RegularPost memory post = RegularPostArray[_postIndex];
      post.category = _newCategory;
    }
}

