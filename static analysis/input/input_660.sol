
pragma solidity ^0.8.0;

contract Prontuario {
    struct Evolucao {
        string categoria;
        string titulo;
        string descricao;
        string data;
    }

    mapping(uint256 => Evolucao) public evolucoes;
    uint256 private index;

    function addEvolucao(Evolucao memory _evolucao) public {
        evolucoes[index] = _evolucao;
        index += 1;
    }

    function getAllEvolucoes() public view returns (Evolucao[] memory) {
        Evolucao[] memory ret = new Evolucao[](index);
        for (uint i = 0; i < index; i++) {
            ret[i] = evolucoes[i];
        }
        return ret;
     }
}


