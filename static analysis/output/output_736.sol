pragma solidity ^0.8.9;
contract ContributionContract {
    mapping(address => uint) public contributors;
    uint public minimumTarget;
    uint public deadline;

    constructor(uint _minimumTarget, uint _deadline) public {
        minimumTarget = _minimumTarget;
        deadline = _deadline;
    }

    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than 0");
        contributors[msg.sender] = msg.value;
    }

    function hasDeadlinePassed() public view returns(bool) {
        return block.timestamp > deadline;
    }

    function recoverContribution() public payable{
        require(hasDeadlinePassed(), "Deadline has not passed, contributions cannot be recovered right now");
        require(!(address(this).balance >= minimumTarget), "Target has been met, cannot recover contributions now");
        require(contributors[msg.sender] != 0, "You have not contributed anything");

        uint contributionAmount = contributors[msg.sender];
        contributors[msg.sender] = 0;
        payable(msg.sender).transfer(contributionAmount);
    }
}

