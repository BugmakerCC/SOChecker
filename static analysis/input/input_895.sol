contract ElectionFactory {
    address[] public deployedElections;
    uint public electionsCount;
    address public owner;

  modifier ownerOnly(){ 
        require(msg.sender == owner); 
        _;
    }
    constructor(){
        owner=msg.sender();
    }
    function createElection() public ownerOnly {
        Election newElection = new Campaign();
        deployedElections.push(address(newElection));
        electionsCount++;
    }

    function getDeployedCampaign(uint index) public view returns (address) {
        return deployedElections[index];
    }

    function getCampaignCounts() public view returns (uint) {
        return campaignsCount;
    }
}


