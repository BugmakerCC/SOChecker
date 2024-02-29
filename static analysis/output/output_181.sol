pragma solidity ^0.8.9;
interface IERC20 {
    function balanceOf(address _owner) external view returns (uint256);

    function transfer(address _to, uint256 _amount) external returns (bool);

    function transferFrom(address _from, address _to, uint256 _amount) external returns (bool);

    function approve(address _spender, uint256 _value) external returns (bool);

    function allowance(address _owner, address _spender) external view returns (uint256);

    event Transfer(address indexed _from, address indexed _to, uint256 amount);

    event Approval(address indexed _owner, address indexed _spender, uint256 amount);
}

