contract MyContract {
    mapping (string => address) tokenUsers;

    function addWhitelist(
        address _t,
        bytes32 _something,
        string memory _id
    ) public {
        tokenUsers[_id] = msg.sender;
        ITargetContract(_t).addCandidateIdToWhitelist(_something, _id);
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4) {
        ITargetContract.safeTransferFrom(
            address(this),
            tokenUsers[_tokenId],
            _stringToUint(_tokenId)
        );
    }
}


