pragma solidity ^0.4.25;
contract Token {
    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public _totalSupply;

    mapping(address => uint256) public balances;

    mapping(address => uint256) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed token, address indexed spender, uint256 value);

    constructor() public {
        name = "Boredom Token";
        symbol = "BOR";
        decimals = 18;
        _totalSupply = 1000000000000 * 1e18;

        _totalSupply = 1000000000000 * (10 ** decimals);

        _totalSupply = 1000000000000 ether;

        _totalSupply = 1000000000000 * 1e18;

        address[3] memory devs = [address(0x123), address(0x456), address(0x789)];
        address dapp = address(0xabc);
        address exchange = address(0xdef);

        uint256 totalSupplyRemaining = _totalSupply;

        uint256 devBalance = _totalSupply / 100;
        for (uint i = 0; i < 3; i++) {
            balances[devs[i]] = devBalance;
            emit Transfer(address(0x0), devs[i], devBalance);
            totalSupplyRemaining -= devBalance;
        }

        uint256 dappBalance = _totalSupply / 2;
        balances[dapp] = dappBalance;
        emit Transfer(address(0x0), dapp, dappBalance);
        totalSupplyRemaining -= dappBalance;

        balances[exchange] = totalSupplyRemaining;
        emit Transfer(address(0x0), exchange, totalSupplyRemaining);
    }

   


    function () external payable {
        revert();
    }

    

    
}

