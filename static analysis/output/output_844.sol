pragma solidity ^0.8.9;
    contract PurchasedCard {

      struct Purchase {
        address cardAddress;
        uint256 timestamp;
      }

      struct User {
        bool exist;
        uint256 numberOfCards;
        address owner;
        address operator;
        bool admin;
        uint256 lastAccess;
        Purchase[] purchase;
      }

      mapping(address => User) public users;

      mapping(uint256 => address)
      public
      cards;


      function checkExistedUser(address user) public view returns (bool) {
        User storage user = users[msg.sender];
        return user.exist;
      }


      function purchaseCard(uint _id) public {
        User storage user = users[msg.sender];
        if (!checkExistedUser(msg.sender)) {
           user.exist = true;
           user.numberOfCards = 0;
        }
        user.purchase.push(Purchase(cards[_id], block.timestamp));
        user.numberOfCards++;
      }


   fallback() external {
     revert("Fallback function");
   }
  }

