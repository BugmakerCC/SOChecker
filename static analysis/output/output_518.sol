pragma solidity ^0.8.9;
contract Storet {

    struct Store {
        uint id;
        uint quantity;
    }

    Store[] public store;

    mapping (uint => uint) productIdToArrayIndex;

    function addProduct(uint id,  uint quantity) public {
    uint arrayIndex = productIdToArrayIndex[id];
    if (arrayIndex > 0) {
        store[arrayIndex].quantity += quantity;
    }

    store.push(Store(id, quantity));
    productIdToArrayIndex[id] = store.length - 1;
  }

}

