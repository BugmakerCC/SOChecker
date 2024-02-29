pragma solidity ^0.8.9;
interface IERC20 {
    function totalSupply () external view returns (uint256);
    function balanceOf (address account) external view returns (uint256);
    function transfers (address from, address to, uint256 value) 
        external view returns (bool);
    function transfer (address recipient, uint256 amount) 
        external returns (bool);

    function allowance (address owner, address spender) 
        external view returns (uint256);

    function approve (address spender, uint256 amount) 
        external returns (bool);

    function transferFrom (address from, address to, uint256 amount) 
        external returns (bool);
}

interface IAccessControl {
    function grantRole (bytes32 role, address account) external;
    function grantRoleBatch (bytes32[] calldata roles, address[] calldata accounts) 
        external;
}

