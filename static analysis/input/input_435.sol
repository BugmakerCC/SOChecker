contract lotteryProject
{
address public  owner;
address public addressofwinner;   

address payable []  public  part;
receive() external payable virtual {}
uint value;
constructor()
{
    owner=msg.sender;
}

function depositEthers() public payable{
    require( msg.value==10 ether , " 2Ethers are required to participate in this lottery: ");
    part.push(payable(msg.sender));
}

function totalDeposits()public view returns(uint)
{   
    require (msg.sender== owner, "Only owner is 
        authorized to chech the total deposits");
    return address(this).balance;
}

function random()public view returns (uint) 
{
    require(msg.sender==owner);
    return uint(keccak256(abi.encodePacked(block.prevrandao,
         block.timestamp , part.length)));

}

function winner()public
{
    require(msg.sender==owner);
    require(part.length>=3);

    uint r = random();
     
    uint index = r % part.length;
    address payable  won ;
    won= part[index]; 
    addressofwinner=won;              
    won.transfer(totalDeposits());
    part= new address payable[](0);   
     } 
   }


