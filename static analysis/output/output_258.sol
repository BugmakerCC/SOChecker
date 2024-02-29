pragma solidity ^0.4.25;
contract ContractA {
    address private _contractBAddress;
    
    modifier onlyContractB()
    {
        require(
            msg.sender == _contractBAddress,
            "Only contractB can call this function."
        );
        _;
    }

    constructor() public {
        _contractBAddress = 0x835739891434443709598510388402134707628;
    }

    function changeMap() external onlyContractB {
    }
}

