// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract transfertot{
    //address  public address1=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; it is owner address sample
    address  public address2=0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;  // it is reciever address sample
        address payable public owner;
        constructor()payable {
            owner=payable(msg.sender);
        }
        
    uint public msgvalue=msg.value;//contract value 
         uint  balance1;//owner balance
         uint  balance2;//reciever balance
         uint[]  balance1arr;
         uint[]  balance2arr;


        function transfer1(address payable  _address,uint _priceGwei)payable public  {
        require(_priceGwei<=(msgvalue/10**9),"balance is less than msgvalue");//working in gwei
            _address.transfer(_priceGwei*10**9);
            balance1=owner.balance/(10**9);
            balance2=address2.balance/(10**9);
            balance1arr.push(balance1);
            balance2arr.push(balance2);
            msgvalue-=_priceGwei*10**9;
        }
    function ownerbalancearr()public view returns(uint[] memory){
        return balance1arr;
    }
     function recieverbalancearr()public view returns(uint[] memory){
        return balance2arr;
    }
}
//when you want to deploy add some gwei to value in deploy and run transactions panel`
//the contract value is differ from owner value
//you can  check the`enter code here` output in this code
//good day to you`

