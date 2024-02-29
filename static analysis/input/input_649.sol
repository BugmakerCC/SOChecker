pragma solidity ^0.5.0;

contract('Token', ([deployer, receiver]) => { 

 const name = 'Arv Token';
 const symbol = 'ARVV';
 const decimals = '18';
 const totalSupply = tokens(1000000).toString();
 let token

    beforeEach(async () => {
        token = await Token.new();
    })


