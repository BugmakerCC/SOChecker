const minterHex = web3.utils.fromAscii('ROLE_MINTER')

bytes32 public constant ROLE_MINTER = keccak256("ROLE_MINTER");

const minterHash = web3.utils.soliditySha3('ROLE_MINTER');
const result = await factoryContract.methods.hasRole(minterHash, OWNER_ADDRESS).call();


