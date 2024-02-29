const privateKey = "82f98661ea7e05ac4bad0965da4b8a1fab93cf27e606d1185a275c91f96aac9b";
const account = web3js.eth.accounts.privateKeyToAccount('0x' + privateKey);
web3js.eth.accounts.wallet.add(account);

const web3 = require('web3');
const fs = require("fs");


const CONTRACT_ABI = `[
        {
                "anonymous": false,
                "inputs": [
                        {
                                "indexed": true,
                                "internalType": "address",
                                "name": "previousOwner",
                                "type": "address"
                        },
                        {
                                "indexed": true,
                                "internalType": "address",
                                "name": "newOwner",
                                "type": "address"
                        }
                ],
                "name": "OwnershipTransferred",
                "type": "event"
        },
        {
                "inputs": [
                        {
                                "internalType": "string",
                                "name": "name",
                                "type": "string"
                        },
                        {
                                "internalType": "bytes1",
                                "name": "pin",
                                "type": "bytes1"
                        }
                ],
                "name": "addAppliance",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
        },
        {
                "inputs": [
                        {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                        }
                ],
                "name": "appliances",
                "outputs": [
                        {
                                "internalType": "uint256",
                                "name": "id",
                                "type": "uint256"
                        },
                        {
                                "internalType": "string",
                                "name": "name",
                                "type": "string"
                        },
                        {
                                "internalType": "bool",
                                "name": "status",
                                "type": "bool"
                        },
                        {
                                "internalType": "bytes1",
                                "name": "pin",
                                "type": "bytes1"
                        }
                ],
                "stateMutability": "view",
                "type": "function"
        },
        {
                "inputs": [
                        {
                                "internalType": "uint256",
                                "name": "id",
                                "type": "uint256"
                        }
                ],
                "name": "getAppliance",
                "outputs": [
                        {
                                "components": [
                                        {
                                                "internalType": "uint256",
                                                "name": "id",
                                                "type": "uint256"
                                        },
                                        {
                                                "internalType": "string",
                                                "name": "name",
                                                "type": "string"
                                        },
                                        {
                                                "internalType": "bool",
                                                "name": "status",
                                                "type": "bool"
                                        },
                                        {
                                                "internalType": "bytes1",
                                                "name": "pin",
                                                "type": "bytes1"
                                        }
                                ],
                                "internalType": "struct Appliance",
                                "name": "",
                                "type": "tuple"
                        }
                ],
                "stateMutability": "view",
                "type": "function"
        },
        {
                "inputs": [],
                "name": "getAppliances",
                "outputs": [
                        {
                                "components": [
                                        {
                                                "internalType": "uint256",
                                                "name": "id",
                                                "type": "uint256"
                                        },
                                        {
                                                "internalType": "string",
                                                "name": "name",
                                                "type": "string"
                                        },
                                        {
                                                "internalType": "bool",
                                                "name": "status",
                                                "type": "bool"
                                        },
                                        {
                                                "internalType": "bytes1",
                                                "name": "pin",
                                                "type": "bytes1"
                                        }
                                ],
                                "internalType": "struct Appliance[]",
                                "name": "",
                                "type": "tuple[]"
                        }
                ],
                "stateMutability": "view",
                "type": "function"
        },
        {
                "inputs": [],
                "name": "getAppliancesCount",
                "outputs": [
                        {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                        }
                ],
                "stateMutability": "view",
                "type": "function"
        },
        {
                "inputs": [],
                "name": "owner",
                "outputs": [
                        {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                        }
                ],
                "stateMutability": "view",
                "type": "function"
        },
        {
                "inputs": [
                        {
                                "internalType": "uint256",
                                "name": "id",
                                "type": "uint256"
                        }
                ],
                "name": "removeAppliance",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
        },
        {
                "inputs": [],
                "name": "renounceOwnership",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
        },
        {
                "inputs": [
                        {
                                "internalType": "uint256",
                                "name": "id",
                                "type": "uint256"
                        },
                        {
                                "internalType": "bool",
                                "name": "status",
                                "type": "bool"
                        }
                ],
                "name": "toggleAppliance",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
        },
        {
                "inputs": [
                        {
                                "internalType": "address",
                                "name": "newOwner",
                                "type": "address"
                        }
                ],
                "name": "transferOwnership",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
        },
        {
                "inputs": [
                        {
                                "internalType": "uint256",
                                "name": "id",
                                "type": "uint256"
                        },
                        {
                                "internalType": "string",
                                "name": "name",
                                "type": "string"
                        },
                        {
                                "internalType": "bytes1",
                                "name": "pin",
                                "type": "bytes1"
                        }
                ],
                "name": "updateAppliance",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
        }
]`;
const CONTRACT_ADDRESS = "0x13d9FA79D364070510B410c2FaC1976F21E3e218";

const web3js = new web3(new web3.providers.HttpProvider("https:


var myAddress = '0x46Be881Fa6935a8FC969A4ddDFC74d625c558996';
const privateKey = "82f98661ea7e05ac4bad0965da4b8a1fab93cf27e606d1185a275c91f96aac9b";
const account = web3js.eth.accounts.privateKeyToAccount('0x' + privateKey);
web3js.eth.accounts.wallet.add(account);

console.log(privateKey);
var contractABI = JSON.parse(CONTRACT_ABI);
var contractAddress = CONTRACT_ADDRESS;
contract = new web3js.eth.Contract(contractABI, contractAddress);


function main() {

    contract.methods.addAppliance("fan", web3.utils.numberToHex(1)).send({ from: myAddress, gas: 230000 })
        .on("receipt", (receipt) => {
            console.log("receipt:");
            console.log(receipt);
            contract.methods.getAppliances().call({ from: myAddress }).then(res => {
                console.log(res);
            });
        });
}

main()


