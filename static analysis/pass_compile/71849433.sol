pragma solidity ^0.8;

contract Target {
    uint public number = 100;
}

contract Factory {
    event DeployedTo(address);

    function deploy(bytes memory code) public returns (address addr) {
        assembly {
            addr := create(0,add(code,0x20), mload(code))
        }

        emit DeployedTo(addr);
    }

    function deployTarget() public {
        this.deploy(
            hex"60806040526064600055348015601457600080fd5b50607d806100236000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c80638381f58a14602d575b600080fd5b603560005481565b60405190815260200160405180910390f3fea26469706673582212204222f4063ba77f82b7d8339b117fd0142d917b7d473221d6bb362a1467d5d83864736f6c63430008070033"
        );
    }
}

