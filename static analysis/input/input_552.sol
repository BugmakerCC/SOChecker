pragma solidity ^0.8.0;

contract MyContract {
    uint256 public myVariable;

    function setVariable(uint256 _myVariable) public {
        myVariable = _myVariable;
    }

    function getVariable() public view returns (uint256) {
        return myVariable;
    }
}

truffle compile

truffle migrate --network name_of_your_network

const myContractJSON = require("./build/contracts/MyContract.json");
const myContractABI = myContractJSON.abi;
const myContractAddress = "0x..."; 
const myContract = new web3.eth.Contract(myContractABI, myContractAddress);

const Web3 = require("web3");
const web3 = new Web3(new Web3.providers.HttpProvider("http:


myContract.methods.getVariable().call().then(console.log);

const accounts = await web3.eth.getAccounts();

myContract.methods.setVariable(5).send({ from: accounts[0] })
  .then(receipt => console.log(receipt));


