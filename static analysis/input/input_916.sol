int public hp = 100;

int internal attack = 20;
int private attackMod = 2;

function test() public view returns(int){
    return attack * attackMod;
}


