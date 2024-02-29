const firstStage = await contractWithSigner.callStatic.firstStage(signer.getAddress());

contract Test {
    event FirstStage(uint256, uint256, string memory);

    function firstStage(address addr) public returns(uint256, uint256, string memory) {

         emit FirstStage(challenge, Mnode, toHex(Hnode));
         return (challenge, Mnode, toHex(Hnode));
     }
}

const transaction = await contractWithSigner.firstStage(signer.getAddress());
const txReceipt = await transaction.wait();
const eventLogs = txReceipt.events;


