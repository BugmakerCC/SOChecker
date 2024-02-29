contract GameItem is ERC721 {

pragma solidity ^0.8;

contract Parent1 {
    constructor(string memory message1) {}
}

contract Parent2 {
    constructor(string memory message2) {}
}

contract Child is Parent1, Parent2 {
    constructor() Parent1("hello") Parent2("world") {}
}


