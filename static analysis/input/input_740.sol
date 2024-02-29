function updatePost(uint256 _postIndex, uint256 _newCategory) external {
    RegularPost storage post = RegularPostArray[_postIndex];
    post.category = _newCategory;
}

function notUpdatePost(uint256 _postIndex, uint256 _newCategory) external {
    RegularPost memory post = RegularPostArray[_postIndex];
    post.category = _newCategory;
}

[
  [
    '1',
    'a',
    'a',
    '0x86beB187A30265Ce437C0BB55f38aF21554659Ae',
    '1',
    category: '1',
    name: 'a',
    post: 'a',
    addr: '0x86beB187A30265Ce437C0BB55f38aF21554659Ae',
    date: '1'
  ],
  [
    '2',
    'b',
    'b',
    '0x86beB187A30265Ce437C0BB55f38aF21554659Ae',
    '2',
    category: '2',
    name: 'b',
    post: 'b',
    addr: '0x86beB187A30265Ce437C0BB55f38aF21554659Ae',
    date: '2'
  ]
]


