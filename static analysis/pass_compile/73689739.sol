pragma solidity ^0.8;

interface ICakeToken {
    function mint(address _to, uint256 _amount) external;
}

interface IBUSD {
    function mint(uint256 amount) external returns (bool);
}

contract MyContract {
    ICakeToken CAKE = ICakeToken(0xFa60D973F7642B748046464e165A65B7323b0DEE);
    IBUSD BUSD = IBUSD(0x8516Fc284AEEaa0374E66037BD2309349FF728eA);

    function mintCake(address to, uint256 amount) external {
        CAKE.mint(to, amount);
    }

    function mintBUSD(uint256 amount) external {
        bool success = BUSD.mint(amount);
        require(success);
    }
}

