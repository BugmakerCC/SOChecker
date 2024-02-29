MyERC20Contract = await ERC20ContractFactory.deploy("Hello","SYM");

constructor(string memory name_, string memory symbol_) {
    name = name_;
    symbol = symbol_;
    _mint(msg.sender, 100e18);
}

someAddress = (await ethers.getSigners())[1];

it("sould transfer tokens correctly", async function() {
    await MyERC20Contract
    .connect(someAddress)
    .transfer(someOtherAddress.address, 10);


