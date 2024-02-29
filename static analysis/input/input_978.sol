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


