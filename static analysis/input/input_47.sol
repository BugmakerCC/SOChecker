mapping(uint => uint[]) Singer;
mapping(uint => uint[]) Event;
uint public n_singers;
uint public n_events;

function CreateEvent(uint singer_id) external {
    if(singer_id > n_singers) {
        revert SingerIdError(singer_id);
    }
    else if (singer_id == n_singers) {
        n_singers ++;
        Singer[singer_id].push(n_events); 
        Event[n_events].push(singer_id);
    } else {
        Singer[singer_id].push(n_events);
    }
    n_events++;
}`


