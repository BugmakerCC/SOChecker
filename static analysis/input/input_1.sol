npm install dotenv --save

 

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "goerli",
  networks: {
     hardhat: {},
     goerli: {
        url:process.env.API_URL,
        accounts: [`0x${process.env.PRIVATE_KEY}`]
     }
  },
};


