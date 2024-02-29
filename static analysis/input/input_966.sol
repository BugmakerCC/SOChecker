uint256 totalRevShare = onDeposit() pub payable {...+=msg.value}

...
uint256 unclaimedScope = totalRevShare - LastTotalRevShare[user];
LastTotalRevShare[user] = totalRevShare;
uint256 _userUnclaimedCut = unclaimedScope / totalReceivers;
...
msg.sender.call{value:_userUnclaimedCut}("");


