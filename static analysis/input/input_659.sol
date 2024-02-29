import "@openzeppelin/contracts/ownership/Ownable.sol";

contract A is Ownable {

    bool public dummy;

    function setDummy (bool x) public onlyOwner {
        dummy = x;
    }

    function getDummy () public view returns (bool) {
        return dummy;
    }
}


