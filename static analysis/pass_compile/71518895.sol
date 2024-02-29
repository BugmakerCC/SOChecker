pragma solidity ^0.8;

contract MyContract {
    struct Game {
        address[] participants;
        uint amountRequired;
        uint Duration;
        uint id;
        bool ended;
        uint createdTime;
    }

    // create a storage mapping of value type `Game`
    // id => Game
    mapping(uint => Game) public games;

    function CreateGame(uint amountRequired, string memory timeoption) public {
        // dummy values
        address[] memory _participants; // empty array by default
        uint gametime = 1;
        uint gameid = 1;

        Game memory newGame = Game({
            participants: _participants,
            amountRequired: amountRequired,
            Duration: gametime,
            id: gameid,
            ended: false,
            createdTime: block.timestamp
        });

        // store the `memory` value into the `storage` mapping
        games[gameid] = newGame;
    }

    function addParticipant(uint gameId, address participant) public {
        require(games[gameId].createdTime > 0, "This game does not exist");
        games[gameId].participants.push(participant);
    }
}

