function withdraw (uint wdraw_amt) public view returns(string memory error){
    if(wdraw_amt<=balance){
     balance -= wdraw_amt;    
    }

function withdraw (uint wdraw_amt) public returns(string memory error){

function withdraw(uint wdraw_amt) public {
    if (wdraw_amt <= balance) {
        balance -= wdraw_amt;
    } else {
        revert("Insufficient Balance");
    }
}

event Error(string _message);

function withdraw(uint wdraw_amt) public {
    if (wdraw_amt <= balance) {
        balance -= wdraw_amt;
    } else {
        emit Error("Insufficient Balance");
    }
}


