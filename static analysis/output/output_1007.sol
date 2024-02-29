pragma solidity ^0.8.9;
contract test {
    
    struct Identity {
        uint age;
        string name;
    }
    
    struct NestedIdentity {
        Identity identity;
    }
    
    Identity identity = Identity(29, 'Issei Kumagai');
    
    NestedIdentity nested_identity = NestedIdentity(identity);
    
    function valueFromStruct() public view returns(uint age, string memory name) {
        return (nested_identity.identity.age, nested_identity.identity.name);
    }

}

