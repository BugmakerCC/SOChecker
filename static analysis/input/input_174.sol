mapping(address => uint) public walletIndexIncrementedMap;
WalletScores[] scores;

struct WalletScores {
    adddress wallet;
    uint256 score;
}


function getOrAddWalletScore(address _wallet, uint256 score) public {
    uint256 incrementedIndex = walletIndexIncrementedMap[_wallet];
    if(0 == incrementedIndex) {
        WalletScore storage walletScore = scores.push();
        incrementedIndex = scores.length;
        walletIndexIncrementedMap[_wallet] = incrementedIndex;
        walletScore.wallet = _wallet;
        walletScore.score = score;
        return;
    }
    WalletScore storage walletScore = scores[incrementedIndex - 1];
    walletScore.score += score;
}

function getAllScores() public returns (WalletScores[] memory walletScores) 
{
   return scores;
}


