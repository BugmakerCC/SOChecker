contract test{
       struct Info {
        uint a;
        uint b;
        uint[] data;
    }
    
    mapping(address => Info) private infos;
    
    function set() public {
        infos[msg.sender].a = 1;
        infos[msg.sender].b = 2;
        infos[msg.sender].data.push(3);
    }
    
    function get() private view{
      infos[msg.sender].a; 
      infos[msg.sender].b; 
      infos[msg.sender].data[0]; 
    } }

contract test{
    struct Info {
        uint a;
        uint b;
        uint[] data;
    }
    
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    mapping(address => Info) infos;
    
    function set() public {
        infos[msg.sender].a = 1;
        infos[msg.sender].b = 2;
        infos[msg.sender].data.push(3);
    }
    
    function get() public view{
      infos[msg.sender].a; 
      infos[msg.sender].b; 
      require(owner == msg.sender, 'you cannot read this data, you are not the owner!');
      infos[msg.sender].data[0]; 
    }
}


