contract B {
    address payable a;

    constructor() {
        a = payable(0xE9F920eE6F15739cc3b2Ac5Ea862C6eB9EEE529b);
    }

    function fund() public payable {
        a.call{value: msg.value}("");
    }
}

