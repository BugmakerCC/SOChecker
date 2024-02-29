struct Users {
        uint dipositTime;
        uint withDrawTime;
        uint lastDepositTime;
}
mapping(address => Users ) users;

function depositeTimeSet(uint t) {
  users[msg.sender].dipositTime = t minutes;
  withdrawalTimeSet(t);
}
function withdrawalTimeSet(uint t) {
  users[msg.sender].withDrawTime = 3 * t minutes
}
function deposite() {
  transferFrom(msg.sender,address(this));
  depositeTimeSet(3); 
  users[msg.sender].lastDepositTime = now;
}
function withdraw() {
  if(
     now > users[msg.sender].lastDepositTime + 
     users[msg.sender].withDrawTime,"too early for withdraw 
     request"
  )
  transferFrom(address(this),msg.sender);
}


