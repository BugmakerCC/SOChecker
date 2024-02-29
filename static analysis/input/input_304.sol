uint public counter;

mapping(uint = > Deposit) public ids; 

function deposit() public payable {

    Deposit storage _deposit = ids[_counter]; 

    _deposit.depositAmount = msg.value; 

    _deposit.depositor = msg.sender;
    
    activeDeposits.push(_deposit);

    _counter++; 

    emit DepositMade(msg.sender, msg.value);
}


