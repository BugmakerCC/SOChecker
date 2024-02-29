enum Animal {CAT, DOG}
mapping(Animal => int8) maps;

constructor() {
        maps[Animal.CAT] = 10;
}

function decrementAnimal(Animal _animal) public {
        maps[_animal] -= 1;
}


