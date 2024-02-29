encode_mwr [type="ethabiencode"
            abi="(bytes32 requestId, string _volume)"
            data="{\\"requestId\\": $(decode_log.requestId), \\"_volume\\": $(volume_parse)}"
            ]

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

 * Request testnet LINK and ETH here: https:
 * Find information on LINK Token Contracts and get the latest ETH and LINK faucets here: https:

contract APIConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;
  
    string public volume;
    
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    
    constructor() {
        setPublicChainlinkToken();
        oracle = 0xF405B99ACa8578B9eb989ee2b69D518aaDb90c1F;
        jobId = "c51694e71fa94217b0f4a71b2a6b565a";
        fee = 0.1 * 10 ** 18; 
    }
    
    
    function requestVolumeData() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        
        request.add("get", "https:
        
        request.add("path", "RAW.ETH.USD.MARKET");
        
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    
 
    function fulfill(bytes32 _requestId, string memory _volume) public recordChainlinkFulfillment(_requestId)
    {
        volume = _volume;
        
    }
    
}

