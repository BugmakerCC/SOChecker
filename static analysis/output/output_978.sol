pragma solidity ^0.8.9;
interface IWETH {
    function deposit() external payable;
    function withdraw(uint wad) external;
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
}

contract Scrath {

    address private immutable weth;

    constructor(address _weth){
       weth = _weth;
    }

    function sendEth() external payable {}

    function ethBalance() public view returns(uint256 _balance) {
        _balance =  address(this).balance;
        return _balance;
    }

    function convertToWeth() external payable {
        uint256 eth = ethBalance();
        IWETH(weth).deposit{value: eth}();
    }

    function wethBalance() external view returns(uint256 _balance) {
        _balance = IWETH(weth).balanceOf(address(this));
        return _balance;
    }

}

