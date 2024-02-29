struct inputData {
    address admin;
    uint256 price;
    uint256 balance;
    address rewardToken;
}

function setAllowedTokensData(address _token, inputData[] memory _data) public {
    for (uint256 dataIndex = 0; dataIndex < _data.length; dataIndex++) {
        allowedTokensData[_token] = allowedTokenDetails(
            _data[dataIndex].admin,
            _data[dataIndex].price,
            _data[dataIndex].balance,
            _data[dataIndex].rewardToken,
            0, 
            block.timestamp
        );
    }
}


