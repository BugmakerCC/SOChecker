pragma solidity ^0.4.25;
contract TokenStaking {

    address[] public stakers;
    address public owner;
    uint8 public stakingRate = 75;

    constructor() public {
        owner = msg.sender;
        stakers = [msg.sender];
    }

    function() public payable {
        require(msg.value > 0, "Staker must deposit Ether to stake");
        stakers.push(msg.sender);
        owner.transfer(msg.value);
    }

    function stake() public payable {
        require(msg.value > 0, "Staker must deposit Ether to stake");
        address sender = msg.sender;
        stakers.push(sender);
        owner.transfer(msg.value);
        sender.transfer(msg.value * (10**18));
    }

    function getStakers() public view returns(address[] memory) {
        return stakers;
    }

    function stakingRate() public view returns(uint8) {
        return stakingRate;
    }

    function setStakingRate(uint8 newRate) public {
        stakingRate = newRate;
    }

}

