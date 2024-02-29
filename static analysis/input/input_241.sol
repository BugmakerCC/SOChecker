encode_data  [type="ethabiencode" abi="(bytes32 requestId, uint256[][] value)" data="{ \\"requestId\\": $(decode_log.requestId), \\"value\\": $(parse) }"]

type = "directrequest"
schemaVersion = 1
name = "shamba-fire-data"
contractAddress = "0xf4434feDd55D3d6573627F39fA39867b23f4Bf7F"
maxTaskDuration = "0s"
observationSource = """
    decode_log   [type="ethabidecodelog"
                  abi="OracleRequest(bytes32 indexed specId, address requester, bytes32 requestId, uint256 payment, address callbackAddr, bytes4 callbackFunctionId, uint256 cancelExpiration, uint256 dataVersion, bytes data)"
                  data="$(jobRun.logData)"
                  topics="$(jobRun.logTopics)"]

    decode_cbor  [type="cborparse" data="$(decode_log.data)"]
    fetch        [type="bridge" name="shamba-fire-bridge" requestData="{\\"id\\": $(jobSpec.externalJobID), \\"data\\":$(decode_cbor.data)}"]
    parse        [type="jsonparse" path="result" data="$(fetch)"]
    encode_data  [type="ethabiencode" abi="(bytes32 requestId, uint256[][] value)" data="{ \\"requestId\\": $(decode_log.requestId), \\"value\\": $(parse) }"]
    encode_tx    [type="ethabiencode"
                  abi="fulfillOracleRequest2(bytes32 requestId, uint256 payment, address callbackAddress, bytes4 callbackFunctionId, uint256 expiration, bytes calldata data)"
                  data="{\\"requestId\\": $(decode_log.requestId), \\"payment\\": $(decode_log.payment), \\"callbackAddress\\": $(decode_log.callbackAddr), \\"callbackFunctionId\\": $(decode_log.callbackFunctionId), \\"expiration\\": $(decode_log.cancelExpiration), \\"data\\": $(encode_data)}"
                 ]
    submit_tx    [type="ethtx" to="0xf4434feDd55D3d6573627F39fA39867b23f4Bf7F" data="$(encode_tx)"]

    decode_log -> decode_cbor -> fetch -> parse -> encode_data -> encode_tx -> submit_tx
"""
externalJobID = "66229880-79e1-43c6-9d9e-0eb4b668729d"

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract GenericLargeResponse is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  uint256[][] public data;

  constructor(
  ) {
    setChainlinkToken(0xa36085F69e2889c224210F603D836748e7dC0088);
    setChainlinkOracle(0xf4434feDd55D3d6573627F39fA39867b23f4Bf7F);
  }

  function requestBytes(
  )
    public
  {
    bytes32 specId = "6622988079e143c69d9e0eb4b668729d";
    uint256 payment = 1000000000000000000;
    Chainlink.Request memory req = buildChainlinkRequest(specId, address(this), this.fulfillBytes.selector);
    req.add("data", "{\"agg_x\": \"agg_mean\", \"dataset_code\":\"MODIS/006/MOD14A1\", \"selected_band\":\"MaxFRP\", \"image_scale\":1000, \"start_date\":\"2021-09-01\", \"end_date\":\"2021-09-10\", \"geometry\":{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"properties\":{\"id\":1},\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[29.53125,19.642587534013032],[29.53125,27.059125784374068],[39.90234375,27.059125784374068],[39.90234375,19.642587534013032],[29.53125,19.642587534013032]]]}},{\"type\":\"Feature\",\"properties\":{\"id\":2},\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[46.40625,13.752724664396988],[46.40625,20.138470312451155],[56.25,20.138470312451155],[56.25,13.752724664396988],[46.40625,13.752724664396988]]]}}]}}");
       
    sendOperatorRequest(req, payment);
  }

  function fulfillBytes(
    bytes32 requestId,
    uint256[][] memory bytesData
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    data = bytesData;
  }

}


