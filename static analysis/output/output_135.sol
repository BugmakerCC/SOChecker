pragma solidity ^0.8.9;
contract MyContract {
    struct Param {
        address owner;
        uint256 amount;
    }

    function callMint(address tokenAddress, Param memory param) external {
        address _owner = param.owner;
        uint256 _amount = param.amount;
        bytes4 _selector = 0x40c10f19;
        assembly {
            let calldataOffset := mload(0x40)
            
            mstore(0x40, add(calldataOffset, 0x44))
            
            mstore(calldataOffset, _selector)
            mstore(add(calldataOffset, 0x04), _owner)
            mstore(add(calldataOffset, 0x24), _amount)
            
            let result := call(
                gas(),
                tokenAddress,
                0,               
                calldataOffset,
                0x44,
                0,               
                0                
            )
            
            if eq(result, 0) {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
        }
    }
}

