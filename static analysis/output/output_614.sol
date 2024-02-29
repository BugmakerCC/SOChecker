pragma solidity ^0.8.9;
contract Kitty_Price_Feed {

    
    struct kitties {
        uint256 kittyPriceToday;
        uint256 kittyPriceTomorrow;
    }

    
    kitties[] public allKitties;

    constructor() public {

        kitties memory _kitty;
        _kitty.kittyPriceToday = 1 ether;
        _kitty.kittyPriceTomorrow = 2 ether;

        allKitties.push(_kitty);

        allKitties[0].kittyPriceToday = 5 ether;
    }

    function getTodayPrice(uint256 kittyId) public view returns(uint256) {
        return allKitties[kittyId].kittyPriceToday;
    }

    function getTomorrowPrice(uint256 kittyId) public view returns(uint256) {
        return allKitties[kittyId].kittyPriceTomorrow;
    }
}

