pragma solidity ^0.8.0;

contract NestedMapping {
    mapping(string => mapping(string => uint8)) private _game_rule_strategy;

    function setNestedMapping(string memory _firstKey, string memory _secondKey, uint8 _value) public {
        _game_rule_strategy[_firstKey][_secondKey] = _value;
    }

    function getValueNestedMapping(string memory _firstKey, string memory _secondKey) external view returns(uint8) {
        return _game_rule_strategy[_firstKey][_secondKey];
    }
}


