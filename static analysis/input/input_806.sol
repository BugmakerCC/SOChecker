allowance[B][C] = 10;

allowance[B][C] =  allowance[B][C] - 6; (10-6 --> C still can send 4 tokens from now on)

allowance[deployer][exchange] =  allowance[deployer][exchange] - _value;

allowance[deployer][exhange] = _value;

token.transferFrom(deployer, receiver, amount).send( { from: exchange } )


