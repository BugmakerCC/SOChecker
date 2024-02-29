pragma solidity ^0.8.9;
contract MusicEvent {
    mapping(uint => uint[]) public Singer;
    mapping(uint => uint[]) public Event;
    uint public n_singers;
    uint public n_events;

    event SingerIdError(uint singer_id);

    constructor() {
        n_singers = 0;
        n_events = 0;
    }

    function CreateEvent(uint singer_id) external {
        if(singer_id > n_singers) {
            emit SingerIdError(singer_id);
        }
        else if (singer_id == n_singers) {
            n_singers ++;
            Singer[singer_id].push(n_events);
            Event[n_events].push(singer_id);
        } else {
            Singer[singer_id].push(n_events);
            Event[n_events].push(singer_id);
        }
        n_events++;
    }
}

