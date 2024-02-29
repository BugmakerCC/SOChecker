pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint256 id;
    string name;
    Ability[] abilities;
  }

  struct Ability {
    string name;
    string description;
  }

  Pokemon[] public pokemons;

  function createPokemon(string memory _name, string memory _abilityNme, string memory _abilityDscription) public {
    uint id = pokemons.length;
    Pokemon storage p = pokemons.push();
    p.abilities.push(Ability(_abilityNme, _abilityDscription));
    p.id = id;
    p.name = _name;
  }
  
  function retrieveAbilities(uint _id) external view returns(Ability[] memory){
    return pokemons[_id].abilities;
  }
}


