pragma solidity ^0.8.9;
contract TokenData {
    struct inputData {
        address admin;
        uint256 price;
        uint256 balance;
        address rewardToken;
    }

    struct allowedTokenDetails {
        address admin;
        uint256 price;
        uint256 balance;
        address rewardToken;
        uint256 lastUpdated;
    }
    
    mapping(address => allowedTokenDetails) public allowedTokensData;

    function setAllowedTokensData(address _token, inputData[] memory _data) public {
        for (uint256 dataIndex = 0; dataIndex < _data.length; dataIndex++) {
            allowedTokensData[_token] = allowedTokenDetails(
                _data[dataIndex].admin,
                _data[dataIndex].price,
                _data[dataIndex].balance,
                _data[dataIndex].rewardToken,
                block.timestamp
            );
        }
    }
}

