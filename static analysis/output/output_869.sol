pragma solidity ^0.8.9;
contract ClaimWithSignature {

    address public _owner;
    mapping(address => uint8) _nonces;

    
    function claim (uint256 amount, uint8 nonce, uint8 v, bytes32 r, bytes32 s) public returns (bool) {

        address user = msg.sender;
        bytes memory hashStructRaw = abi.encode(
            user,
            amount,
            nonce
        );

        bytes32 hashStruct = keccak256(hashStructRaw);
        address signerRecovered = ecrecover(hashStruct, v, r, s);
        
        require(signerRecovered == _owner, "invalid signature");
        require(nonce > _nonces[user], "nonce too low");


        _nonces[user] = nonce;
        return true;
    }
}

