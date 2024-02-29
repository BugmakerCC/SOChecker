function sendGift(uint256 _mintAmount,address recipient) public {

payable(admin).call{value: address(this).balance}("");

admin.transfer(address(this).balance);

payable(admin).transfer(address(this).balance);

interface IERC20 {
    function transfer(address, uint256) external returns (bool);
}

contract MyContract {
    function withdrawToken() {
        IERC20(tokenContractAddress).transfer(recipient, amount);
    }
}


