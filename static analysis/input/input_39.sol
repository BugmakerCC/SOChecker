pragma solidity 0.8.13;

contract TestLoop {
    uint32[4] testArray;

    function setArrayWithLoop(uint32[4] memory array) public {
        for(uint256 i = 0; i < array.length; i++)
            testArray[i] = array[i];
    }

    function setArrayWithoutLoop(uint32[4] memory array) public {
        testArray = array;
    }

    function show() public view returns (uint32[4] memory) {
        return testArray;
    }
}

contract NoLoop {
    uint32[4] testArray;

    constructor(uint32[4] memory array) {
        testArray = array;
    }

    function show() public view returns (uint32[4] memory) {
        return testArray;
    }
}

contract Loop {
    uint32[4] testArray;

    constructor (uint32[4] memory array) {
        for(uint256 i = 0; i < array.length; i++)
            testArray[i] = array[i];
    }

    function show() public view returns (uint32[4] memory) {
        return testArray;
    }
}

from brownie import TestLoop, NoLoop, Loop, accounts

def function_calls():
    contract = TestLoop.deploy({'from': accounts[0]})
    print('set array in loop')
    contract.setArrayWithLoop([1, 2, 3, 4], {'from': accounts[1]})
    print('array ', contract.show(), '\n\n')

    print('set array by copy from memory to storage')
    contract.setArrayWithoutLoop([10, 9, 8, 7], {'from': accounts[2]})
    print('array ', contract.show(), '\n\n')

def deploy_no_loop():
    print('deploy NoLoop contract')
    contract = NoLoop.deploy([21, 22, 23, 24], {'from': accounts[3]})
    print('array ', contract.show(), '\n\n')

def deploy_loop():
    print('deploy Loop contract')
    contract = Loop.deploy([31, 32, 33, 34], {'from': accounts[3]})
    print('array ', contract.show(), '\n\n')

def main():
    function_calls()
    deploy_no_loop()
    deploy_loop()

compiler:
  solc:
    version: 0.8.13
    optimizer:
      enabled: true
      runs: 1

Running 'scripts/test_loop.py::main'...
Transaction sent: 0x8380ef4abff179f08ba9704826fc44961d212e5ee10952ed3904b5ec7828c928
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
  TestLoop.constructor confirmed   Block: 1   Gas used: 251810 (2.10%)
  TestLoop deployed at: 0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87

set array in loop
Transaction sent: 0xfe72d6c878a980a9eeefee1dccdd0fe8214ee4772ab68ff0ac2b72708b7ab946
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
  TestLoop.setArrayWithLoop confirmed   Block: 2   Gas used: 49454 (0.41%)

array  (1, 2, 3, 4) 


set array by copy from memory to storage
Transaction sent: 0x0106d1a7e37b155993a6d32d5cc9dc67696a55acd1cf29d2ed9dba0770436b98
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
  TestLoop.setArrayWithoutLoop confirmed   Block: 3   Gas used: 41283 (0.34%)

array  (10, 9, 8, 7) 


deploy NoLoop contract
Transaction sent: 0x55ddded68300bb8f11b3b43580c58fed3431a2823bf3f82f0081c7bfce66f34d
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
  NoLoop.constructor confirmed   Block: 4   Gas used: 160753 (1.34%)
  NoLoop deployed at: 0x7CA3dB74F7b6cd8D6Db1D34dEc2eA3c89a3417ec

array  (21, 22, 23, 24) 


deploy Loop contract
Transaction sent: 0x1aa64f2cd527983df84cfdca5cfd7a281ff904cca227629ec8b0b29db561c043
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 1
  Loop.constructor confirmed   Block: 5   Gas used: 153692 (1.28%)
  Loop deployed at: 0x2fb0fE4F05B7C8576F60A5BEEE35c23632Dc0C27

array  (31, 32, 33, 34)


