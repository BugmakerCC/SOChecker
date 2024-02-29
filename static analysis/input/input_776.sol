import "@openzeppelin/contracts/access/Ownable.sol";

contract A is Ownable {

    receive() external payable {}

    function getCurrentBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }
}

interface I {
    function getCurrentBalance() external view returns (uint) ;
    function transferOwnership(address newOwner) external;
}


contract B is Ownable {

    I public itf = I(contract_A_address_); 

    receive() external payable {}

    function getBalanceOfA() public view onlyOwner returns (uint) {
        return itf.getCurrentBalance();
    }

    function changeAOwner(address newOwner) public onlyOwner{
        itf.transferOwnership(newOwner);
    }
}


