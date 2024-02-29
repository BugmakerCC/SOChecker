mapping(address => experience) experiences;

function addExperience(...) public {
    experiences[_addressCompagnie] = experience(...);
}

mapping(address => experience[]) experiences;

function addExperience(...) public {
    experiences[_addressCompagnie].push(experience(...));
}


