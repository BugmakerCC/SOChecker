mapping(string -> address[]) paidUsers;
function pay(string memory _title) public payable {
   require(msg.value == movieInfo[_title].price, "Invalid price for the film");
   
   paidUsers[_title].push(msg.sender);
}


