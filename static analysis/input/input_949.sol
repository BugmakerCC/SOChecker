    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

const txResponse = await myNFT.mintNFT(deployer.address, newMintItem.uri);

const txReceipt = await txResponse.wait();

const [transferEvent] = txReceipt.events;

const { tokenId } = transferEvent.args;

describe('Receiving a value returned by a transacting function', () => {
    it('Should return a correct ID of the newly minted item', async () => {
      const newMintItem = {
        id: 1,
        uri: 'ipfs:
      };
      const txResponse = await myNFT.mintNFT(deployer.address, newMintItem.uri);
      const txReceipt = await txResponse.wait();
      const [transferEvent] = txReceipt.events;
      const { tokenId } = transferEvent.args;
      expect(tokenId).to.equal(newMintItem.id);
    });
  });


