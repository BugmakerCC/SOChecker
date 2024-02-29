function getCardsByOwner(address user) external view returns(uint[] memory _cards) {
    uint[] memory result = new uint[](userToCardsCount[user]);
    uint counter = 0;
    for (uint i = 0; i < cards.length; i++) {
        if (cardIdToUser[i] == user) {
            result[counter] = cards[i];
            counter++;
        }
    }
    return result;
}

const getCards = async () => {
    if (typeof window.ethereum !== 'undefined'){
        const provider = new ethers.providers.Web3Provider(window.ethereum) 
        const signer = provider.getSigner()
        const contract = new ethers.Contract(cardsAddress, Cards.abi, signer)
        try {
            const data = await contract.getCardsByOwner(signer.getAddress())
            console.log(await contract.getOwnCards())
            console.log(data)
        } catch (error) {
            console.log(error)
        }
    }
}


