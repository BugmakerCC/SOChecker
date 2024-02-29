pragma solidity ^0.8;

contract MyContract {
    uint256[] array = [100, 200, 300, 400, 500];

    function remove(uint256 index) external {
        require(array.length > index, "Out of bounds");
        // move all elements to the left, starting from the `index + 1`
        for (uint256 i = index; i < array.length - 1; i++) {
            array[i] = array[i+1];
        }
        array.pop(); // delete the last item
    }

    function getArray() external view returns (uint256[] memory) {
        return array;
    }
}

