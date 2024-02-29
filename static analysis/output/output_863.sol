pragma solidity ^0.5.4;
library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size: = extcodesize(account)
        }
        return size > 0;
    }
}

interface IERC20 {

function transfer(address to, uint value) external returns (bool);

function getPendingWithdrawals() external view returns (uint[] memory);

function setPendingWithdrawals(uint[] calldata withdrawals) external;

}

