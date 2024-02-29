function addProduct(uint id,  uint quantity) public {
    for (uint i; i < store.length; i++) {
        if (store[i].id == id) {
            store[i].quantity += quantity;
            return;
        }
    }

    store.push(Store(id, quantity));
}

mapping (uint => uint) productIdToArrayIndex;

function addProduct(uint id,  uint quantity) public {
    uint arrayIndex = productIdToArrayIndex[id];
    if (arrayIndex > 0) {
        store[arrayIndex].quantity += quantity;
    }

    store.push(Store(id, quantity));
    productIdToArrayIndex[id] = store.length - 1;
}


