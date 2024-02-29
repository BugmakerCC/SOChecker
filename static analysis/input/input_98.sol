    struct Users{
       string fullname;
       string[] email;
    }
    mapping(address => Users) private userinfo;

    function compareString(string memory str1, string memory str2) internal returns (bool) {
        if(bytes(str1).length != bytes(str2).length) {
            return false;
        } else {
            return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
        }
    }

    function removeEmail(address userAddress, string memory emailToRemove) external {
        string[] memory emails = userinfo[userAddress].email;
        uint256 emailLength = emails.length;
        for (uint256 i; i<emailLength; i++) {
            if (compareString(emails[i], emailToRemove)) {
                userinfo[userAddress].email[i] = userinfo[userAddress].email[emailLength - 1];
                userinfo[userAddress].email.pop();
                break;
            }
        }
    }


