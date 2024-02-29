function getIndex(address walletAddress) view private returns(uint){
  for (uint i = 0; i < kids.length; i++){
    if(kids[i].walletAddress == walletAddress){{ 
      return i;
    }
  }
 return 999;
}

function getIndex(address walletAddress) view private returns(uint){
  for (uint i = 0; i < kids.length; i++){
    if(kids[i].walletAddress == walletAddress) {
      return i;
    }
  }
 return 999;
}


