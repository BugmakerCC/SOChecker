function transferEther(address receiver) external payable {
    payable(receiver).call{value: msg.value}("");
}

address payable public owner;

function transferEther() external payable {
    owner = payable(msg.sender);


    owner.call{value: msg.value}("");


