function foo() public {
    token.transfer(recipient, amount);
}

function foo() public {
    (bool success, bytes memory returnedData) = address(token).call(
        abi.encodeWithSignature(
            "transfer(address,uint256)",
            recipient,
            amount
        )
    );
}

function foo() public {
    try token.transfer(recipient, amount) returns (bool) {

    } catch Error (string memory reason) {

    }
}


