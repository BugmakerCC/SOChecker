// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TestContract {

  struct Item {
    uint itemId;
    uint itemValue;
  }

  struct OverlayingItemStruct {
    mapping(uint => Item) items;
    uint overlayingId;
    uint itemsCount;
  }

  mapping(uint => OverlayingItemStruct) public overlayingItems;
  
  uint public overlayCount;

  function addOverlayingItemsStruct(uint _value) external {
    overlayCount ++;
    // NOTE: I declared a new Item struct
    Item memory item = Item(1, _value);
    // NOTE: I set into items mapping key value 1, Item struct created in row above this 
    overlayingItems[overlayCount].items[1] = item;
  }

  function addItem(uint _value, uint _overlayId) external {
    OverlayingItemStruct storage overlay = overlayingItems[_overlayId];
    overlay.itemsCount ++;
    overlay.items[overlay.itemsCount] = Item(overlay.itemsCount, _value);
  }
}  

