
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

import { $abiUtils } from '@dequanto/utils/$abiUtils';
import { $contract } from '@dequanto/utils/$contract';
import { $signRaw } from '@dequanto/utils/$signRaw';

export async function getTxData (userId) {

    let { user, amount, nonce } = loadUserData(userId);

    let encodedParams = $abiUtils.encode([
        'address',
        'uint256',
        'uint8',
    ], [
        user.address,
        amount,
        nonce
    ]);
    
    let hash = $contract.keccak256(encodedParams);
    
    let { v, r, s } = await $signRaw.signEC(hash, owner.key);
    

    return { user, amount, nonce, v, r, s };
}


