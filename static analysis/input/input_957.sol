Array(parseInt(requestCount))

function getRequests() external view returns (Request[] memory) {
    return requests;
}

const requests = await campaign.methods.getRequests().call();


