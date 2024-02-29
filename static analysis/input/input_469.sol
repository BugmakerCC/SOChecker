contract FreezableToken is StandardToken {
    using SafeMath for uint;

    function getFreezing() public {
        for (uint i = 0; i < _index.add(1); i = i.add(1)) {


