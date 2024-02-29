address public payable Beneficiary;

payable(Beneficiary).transfer(address(this).balance);

(bool success,) = payable(Beneficiary).call{value: address(this).balance}(""); 
require(success, "transaction failed");


