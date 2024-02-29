pragma solidity ^0.7;

contract MyContract {
    function foo() external pure returns (uint256) {
        return uint(-1);
    }
}

pragma solidity ^0.8;

contract MyContract {
    function foo() external pure returns (uint256) {
        uint256 number = 0;
        number--;
        return number;
    }
}

const BN = web3.utils.BN;
const number = (new BN(2)).pow(new BN(8)).sub(new BN(1));
console.log(number.toString());

const BN = web3.utils.BN;
const number = (new BN(2)).pow(new BN(256)).sub(new BN(1));
console.log(number.toString());


