pragma solidity ^0.8.9;
contract WalletScoreContract {

    mapping(address => uint) public walletIndexIncrementedMap;
    WalletScores[] public scores;

    struct WalletScores {
        address wallet;
        uint256 score;
    }

    function getOrAddWalletScore(address _wallet, uint256 _score) public {
        uint256 incrementedIndex = walletIndexIncrementedMap[_wallet];
        if(0 == incrementedIndex) {
            WalletScores memory walletScore = WalletScores(_wallet, _score);
            scores.push(walletScore);
            incrementedIndex = scores.length;
            walletIndexIncrementedMap[_wallet] = incrementedIndex;
            return;
        }
        WalletScores storage walletScore = scores[incrementedIndex - 1];
        walletScore.score += _score;
    }

    function getAllScores() public view returns (WalletScores[] memory) 
    {
       return scores;
    }
}

