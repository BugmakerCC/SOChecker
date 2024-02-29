pragma solidity ^0.8.9;
contract Testing {

    struct Schema {
        mapping(string => string) entity;
    }

    struct SchemaMapping {
        string[] key;
        string[] value;
    }

    mapping(uint256 => Schema) schemas;
    mapping(uint256 => SchemaMapping[]) schemaMappings;

    function createSchema(uint256 id, string memory key, string memory value) public {
        SchemaMapping[] storage schemamapping = schemaMappings[id];
        SchemaMapping storage singleSchemaItem = schemamapping.push();
        singleSchemaItem.key.push(key);
        singleSchemaItem.value.push(value);

        schemas[id].entity[key] = value;
    }

    function getSchemaElemet(uint256 id) public view returns (SchemaMapping[] memory) {
        return schemaMappings[id];
    }
 }

