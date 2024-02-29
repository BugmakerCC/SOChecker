function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

uint256 fee = 0.1 ether;
function transferFrom(address _from, address _to, uint256 _tokenId) external payable{
    require(msg.value >= fee, "sent ether is lower than fee")
}


