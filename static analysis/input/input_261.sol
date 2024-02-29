contract FunWithStorage {
    uint256 public favoriteNumber = 20; 

    string private test = "hello1adsfdsfds"; 
    bool public someBool = false; 


    uint256[] public myArray; 
}

let ARRAY_SLOT = 3;

let ITEM_SLOT = 0;

let length = BigInt(await getStorageAt(ARRAY_SLOT));

let location = BigInt(keccak256(encodePacked(ARRAY_SLOT))) + BigInt(ITEM_SLOT);
let memory = await getStorageAt(location);

contract Foo {
    type User { 
        address owner;
        uint balance;
    }
    User[] users;
}

let ITEM_SLOT = ARRAY_ITEM_INDEX * ITEM_SIZE + ITEM_INDEX
let ITEM_SLOT = 3 * 2 + 1;


