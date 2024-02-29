_owners[0] = '0x11'
_owners[1] = '0x22'
_owners[2] = '0x33'
_owners[3] = '0x44'

totalSupply = 4

delete _owners[2]
total -= 1

for (uint256 i; i < total; i++) {
   tokenIds[i] = ownerOf(i);
}


