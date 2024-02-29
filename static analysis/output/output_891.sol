pragma solidity ^0.8.9;
interface IArtwork {
    function buyNumber(
        uint128 id,
        bytes calldata payment
    ) external payable;
}

contract BuyArtwork {
    address private artwork;

    constructor(address _artwork) public {
        artwork = _artwork;
    }

    function buyNumber(
        uint128 id,
        bytes calldata payment
    )
    external payable {
        IArtwork(artwork).buyNumber(id, payment);
    }
}

