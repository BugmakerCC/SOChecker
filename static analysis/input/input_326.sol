function getUserBalance(address _owner) external view returns (uint) {
    return address(_owner).balance;
}

function getContractBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

balanceOf(owner.address)


