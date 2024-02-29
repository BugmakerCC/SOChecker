pragma solidity ^0.8.9;
interface IToken {
    function approve(address _spender, uint256 _amount) external returns (bool);
    function transfer(address _to, uint256 _value) external payable returns (bool);
    function transferFrom(address _from, address _to, uint256 _value)
        external
        returns (bool);
    function balanceOf(address _owner) external view returns (uint);

    event Approval(address indexed _owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

interface IStakerBank {
    function stake(uint256 amount) external;
    function withdraw(uint256 amount) external returns (uint256);
}

