pragma solidity ^0.8.9;
contract MyContract {

    struct A {
        string id;
    }

    struct B {
        string id;
    }

    function getIndex(A[] memory arr, string memory _id) internal pure returns (uint256) {
        for (uint i=0; i<arr.length; i++) {
            if (keccak256(abi.encodePacked((arr[i].id))) == keccak256(abi.encodePacked((_id)))) {
                return i;
            }
        }
        return arr.length;
    }

    function getIndex(B[] memory arr, string memory _id) internal pure returns (uint256){
        for (uint i=0; i<arr.length; i++) {
            if (keccak256(abi.encodePacked((arr[i].id))) == keccak256(abi.encodePacked((_id)))) {
                return i;
            }
        }
        return arr.length;
    }

    function _commonFunction() internal pure {}
}

