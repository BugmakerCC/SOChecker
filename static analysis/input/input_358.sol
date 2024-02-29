contract Cloth {
    struct Clothes {
        string name;
        string color;
    }

    Clothes[5] public clothes;
    uint counter = 0;

    function addCloth(string calldata _name, string calldata _color) public {
        require(counter < 5, "Can't add more clothes. Limit of the array reached.");
        clothes[counter] = Clothes(_name,_color);
        counter++;
    }
}

