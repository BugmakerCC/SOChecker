token.transferFrom(address(this), address(this), 10);

function createSubDAO (uint _poolGap, uint _DAOID, uint _rate, Dtoken _token) public returns (address daoAddress) {
    SubDAO subDAO = new SubDAO(_poolGap, _DAOID, msg.sender, _rate, this, _token);
    daoAddress = address(subDAO);

    Dtoken(_token).transfer(daoAddress, 10);
}}


