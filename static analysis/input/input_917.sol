contract NFT_Price_Agreement {

    bool reachedAgreement = false;    
    uint numParties = 3;
    uint numSigned = 0;
    uint totalVal = 0;

    uint nftPrice = 1000000000000000000; 

    mapping(address => uint) public nftStake;

    function makeReq(uint reqStake) public {
        uint stake = nftPrice * (reqStake / 100);
        totalVal += stake; 
        nftStake[msg.sender] = stake;
        numSigned++;
    }

    function confirmReq() public {
        require(numSigned == numParties, "Not everyone has agreed on what percent ownership.");
        require(totalVal == nftPrice);
        reachedAgreement = true;
    }
}


