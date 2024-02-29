pragma solidity ^0.8.9;
interface EACAggregatorProxy {
    function latestAnswer() external view returns (int256);
}

contract oracleLink {

    address public dev;
    uint public devDeposit;
    uint[] public devDeposits;

    address[] public users;                   
    uint[] public totalDeposited;  

    mapping(address => uint) balances;

    function deployerIsDeveloper() public payable {
        dev = msg.sender;
        devDeposit = msg.value;
        devDeposits.push(devDeposit);                   
    }

    address user;
    uint amountDeposit;
    uint256 deadline;

    uint256 lockAmount = lockAmounts[msg.sender];
    mapping(address => uint) lockAmounts;

    uint256 startTime = startTimes[block.timestamp];
    mapping(uint => uint) startTimes; 

    address public chainLinkETHUSDAddress = 0x9326BFA02ADD2366b30bacB125260Af641031331;

    uint public ethPrice = 0; 
    uint256 price = ethPrice;
    mapping(uint => uint) mappingEthPrice;

    function deposit(uint256 numberOfSeconds) public payable {

        lockAmounts[msg.sender] = msg.value;
        startTimes[block.timestamp] = block.timestamp;
        
        user = msg.sender;           
        amountDeposit = msg.value;      
        
        users.push(user);                     
        totalDeposited.push(amountDeposit);

        deadline = block.timestamp + (numberOfSeconds * 1 seconds);

        int256 chainLinkEthPrice = EACAggregatorProxy(chainLinkETHUSDAddress).latestAnswer();
        ethPrice = uint(chainLinkEthPrice / 100000000);
    }

    function withdraw() public payable {
        require(block.timestamp >= deadline);
        uint amountToWithdraw = lockAmounts[msg.sender];
        lockAmounts[msg.sender] = 0; 
        payable(msg.sender).transfer(amountToWithdraw); 
    }
}

