pragma solidity ^0.8.9;
contract AttackModifier {
    int public hp = 100;

    int internal attack = 20;
    int private attackMod = 2;

    function test() public view returns(int) {
        return attack * attackMod;
    }

    function modifyAttack(int amount) private {
        attackMod += amount;
    }
}

