import Station from './build/Station.json';



  const station = (address) => {
    return new web3.eth.Contract(JSON.parse(Station.interface), address);
  };

export default station;

pragma solidity ^0.4.17;
contract StationFactory {
    address[] public deployedStations;

    function createStation(uint minimum) public {
        address newStation = new Station(minimum, msg.sender);
        deployedStations.push(newStation);
    }

    function getDeployedStations() public view returns (address[]) {
        return deployedStations;
    }
}

contract Station {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount;

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function Station(uint minimum, address creator) public {
        manager = creator;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);

        approvers[msg.sender] = true;
        approversCount++;
    }

    function createRequest(string description, uint value, address recipient) public restricted {
        Request memory newRequest = Request({
           description: description,
           value: value,
           recipient: recipient,
           complete: false,
           approvalCount: 0
        });

        requests.push(newRequest);
    }

    function approveRequest(uint index) public {
        Request storage request = requests[index];

        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];

        require(request.approvalCount > (approversCount / 2));
        require(!request.complete);

        request.recipient.transfer(request.value);
        request.complete = true;
    }

    function getSummary() public view returns (
      uint, uint, uint, uint, address
      ) {
        return (
          minimumContribution,
          this.balance,
          requests.length,
          approversCount,
          manager
        );
    }

    function getRequestsCount() public view returns (uint) {
        return requests.length;
    }
}


const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const compiledCRMS = require('./build/crms.json');
const compiledStationFactory = require('./build/StationFactory.json');

const provider = new HDWalletProvider(
  'YOUR METAMASK PHRASE',
  'INFURA LINK'
);

const web3 = new Web3(provider);


const deploy = async()=>{
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account', accounts[0]);
const result =  await new web3.eth.Contract(JSON.parse(compiledCRMS.interface))
  .deploy({data:compiledCRMS.bytecode })
  .send({gas:'10000000',from:accounts[0]});

const result_1 = await new web3.eth.Contract(JSON.parse(compiledStationFactory.interface))
.deploy({data:compiledStationFactory.bytecode})
.send({gas:'10000000',from:accounts[0]});


console.log('CRMS Contract deployed to',result.options.address);
console.log('Station Factory Contract deployed to',result_1.options.address);
provider.engine.stop();
};
deploy();




