function foo() public {
    try this.transfer(address(0x123), 2) {
    } catch (bytes memory data) {
    }
}

function foo() public {
    try this.transfer(address(0x123), 2) {
    } catch Error (string memory reason) {
    }
}

require(balance[msg.sender]<amount, "Insufficient Balance");

require(balance[msg.sender] => amount, "Insufficient Balance");


