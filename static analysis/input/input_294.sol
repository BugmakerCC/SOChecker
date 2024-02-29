pragma solidity ^0.8;

contract MyContract {
    event DataRequested(string url);

    function requestData(string memory url) public {
        emit DataRequested(url);
    }

    function receiveData(bytes memory data) public {
        require(msg.sender == address(0x123));
    }
}

const Web3 = require("web3");
const web3 = new Web3(YOUR_NODE_URL);

const myContract = new web3.eth.Contract(ABI, ADDRESS);

myContract.events.DataRequested(async (eventData) => {
    const result = queryUrl(eventData.returnValues.url);

    await myContract.methods.receiveData(result).send({
        from: "0x123"
    });
});


