pragma solidity ^0.8.9;
library SafeERC20 {

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 tokenId
    ) internal {
        (bool success, ) = token.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)", from, to, tokenId
            )
        );
        require(success, "transferFrom of token failed");
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 tokenId,
        uint256 numTokens
    ) internal {
        (bool success, ) = token.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)", from, to, tokenId
            )
        );
        require(success, "transferFrom of token failed");
    }
}

