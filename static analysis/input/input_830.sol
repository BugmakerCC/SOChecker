function getContractOwner() public view returns (address)
  {
    return owner;
  }

contract("MyContract", accounts => {
     let _contract = null
     let currentOwner=null

    before(async () => {
      _contract = await MyContract.deployed();
      currentOwner = await _contract.getContractOwner()          
    })    
    it("should deploy the contract and allow the user", async () => {
        const account = accounts[0];
        await contract.allowUser(account, {from: currentOwner});
        const allowedUser = _contract.allowedUser.call(0);
        assert.equal(whitelistedUser, account, 'new user is not allowed');
    })
});


