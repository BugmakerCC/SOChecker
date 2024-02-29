pragma solidity ^0.8;

contract MyContract {
    uint256 public publicUint256;
}

contract MyChildContract is MyContract {

    function setValue(uint256 _value) external {
        publicUint256 = _value;
    }

    function getValue() external view returns (uint256) {
        return publicUint256;
    }

    function getValue2() external view returns (uint256) {
        return this.publicUint256();
    }
}


