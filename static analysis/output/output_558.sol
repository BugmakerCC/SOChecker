// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract MappingsC {
    struct Item {
        uint groupId;
        uint itemId;
    }
    
    mapping(uint => Item[]) private items;
    
    function setItem(uint groupId, uint itemId) public {
        items[groupId].push(Item(groupId, itemId));
    }

    function getItem(uint groupId, uint itemId) public view returns (Item memory) {
        return items[groupId][itemId];
    }
    
    function getItems(uint groupId) public view returns (Item[] memory) {
        return items[groupId];
    }
}

