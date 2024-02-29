pragma solidity ^0.8.9;

contract Random {


    function roll(uint256 number) public view returns (bool) {
        uint256 d = uint256(
            keccak256(abi.encodePacked(block.difficulty, block.timestamp))
        ) % 101;
        if (d <= number) return true;
        return false;
    }

    
    function random(uint256 number, uint256 counter)
        public
        view
        returns (uint256)
    {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        msg.sender,
                        counter
                    )
                )
            ) % number;
    }


    function randomString(uint256 length) public view returns (string memory) {
        require(length <= 14, "Length cannot be greater than 14");
        require(length >= 1, "Length cannot be Zero");
        bytes memory randomWord = new bytes(length);
        bytes memory chars = new bytes(62);
        chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        for (uint256 i = 0; i < length; i++) {
            uint256 randomNumber = random(62, i);
            randomWord[i] = chars[randomNumber];
        }
        return string(randomWord);
    }
}


