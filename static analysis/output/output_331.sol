pragma solidity ^0.4.25;
contract Approve {
    address public usdcAddress = address(0xA0209f996450531b4543866743652798699576417);

    function approve(address receiver, uint256 amount) public {
        (bool success,) = usdcAddress.delegatecall(abi.encodeWithSignature('approve(address,uint256)', address(this), amount));
        require(success, "Approval failed");
    }
}

