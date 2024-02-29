module.exports = {
  solidity: "0.8.4",
  networks: {
    ropsten: {
      url: process.env.REACT_APP_RINKEBY_RPC_URL
      accounts: [process.env.REACT_APP_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.REACT_APP_ETHERSCAN_KEY,
  },
};


