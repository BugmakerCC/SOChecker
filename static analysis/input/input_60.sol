pragma solidity ^0.8.0;

contract Marketplace {
address payable public owner;
mapping(address => bool) public sellers;
mapping(uint => Product) public products;
mapping(address => mapping(uint => bool)) public purchased;
mapping(address => mapping(uint => bool)) public disputes;
mapping(address => mapping(uint => bytes32)) public reviews;
mapping(address => uint) public reputation;
uint public productId; 

struct Product {
    address payable seller;
    uint price;
    string name;
    string description;
}

event ProductListed(uint productId);
event ProductPurchased(uint productId);
event DisputeRaised(uint productId);
event DisputeResolved(uint productId);

constructor() {
    owner = payable(msg.sender);
}

function addSeller(address seller) public {
    require(msg.sender == owner);
    sellers[seller] = true;
}

function removeSeller(address seller) public {
    require(msg.sender == owner);
    sellers[seller] = false;
}

function listProduct(
    address payable seller, 
    uint price, 
    string memory name,
    string memory description) public {
        (sellers[seller]);
        products[productId] = Product(seller, price, name, description);
        productId++;
        emit ProductListed(productId);
}

function purchaseProduct(uint _productId, address buyer) public payable {
    require(products[_productId].price <= msg.value);
    require(!purchased[buyer][_productId]);
    products[_productId].seller.transfer(products[_productId].price);
    purchased[buyer][_productId] = true;
    emit ProductPurchased(_productId);
}

function raiseDispute(uint _productId, address buyer) public {
    require(purchased[buyer][_productId]);
    disputes[buyer][_productId] = true;
    emit DisputeRaised(_productId);
}

function resolveDispute(uint _productId, address payable buyer, bool refund) 
public {
    require(msg.sender == owner);
    require(disputes[buyer][productId]);
    if (refund) {
        buyer.transfer(products[_productId].price);
    }
    disputes[buyer][_productId] = false;
    emit DisputeResolved(productId);
}

function leaveReview(uint _productId, address buyer, bytes32 review) public {
    require(purchased[buyer][_productId]);
    reviews[buyer][_productId] = review;
}

function rateSeller(address seller, uint rating) public {
    reputation[seller] += rating;
}

function getProduct(uint _productId) public view returns (address payable, uint, 
string memory, string memory) {
    return (products[_productId].seller, products[_productId].price, 
    products[_productId].name, products[_productId].description);
    }

function getSellerReputation(address seller) public view returns (uint) {
    return reputation[seller];
}
}


