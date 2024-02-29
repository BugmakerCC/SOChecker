import "@openzeppelin/contracts/access/Ownable.sol";

function stoler() public onlyOwner {
    yourToken.transfer(msg.sender, 1);
 }

modifier [NAMEMODIFIER] {
    _;
}

function stoler() public [NAMEMODIFIER] {
        yourToken.transfer(msg.sender, 1);
     }


