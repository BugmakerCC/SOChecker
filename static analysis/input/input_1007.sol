pragma solidity >= 0.7.0 < 0.9.0;

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

function valueFromStruct() public view returns(Identity memory) {
    return nested_identity.identity;
}


