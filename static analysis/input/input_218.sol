function getContractOwner() public view returns (address)
  {
    return owner;
  }

contract("YourContract", (accounts) => {

  let _contract = null;
  let buyer = null;
  before(async () => {
    _contract = await YourContractName.deployed();
    buyer = accounts[1];
  });

  describe("Normal withdraw", () => {
    let currentOwner = null;
    before(async () => {
      currentOwner = await _contract.getContractOwner();
    });
    it("should fail when withdrawing by different than owner address", async () => {
      const value = "10000000000000000";
      _contract.withdraw(value, { from: buyer });
    });
}
}


