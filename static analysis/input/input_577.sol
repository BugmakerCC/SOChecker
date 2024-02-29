compiled_sol=compile_standard({
    # not "solidity"
    "language":"Solidity",
    # not "simpleStorage"
    "sources":{"SimpleStorage.sol":{"content":simple_storage_file}},
    "settings":{
        "outputSelection":{
            "*":{
                "*":["abi","metadata","evm.bytecode","evm.sourceMap"]
            }
        }
    }
},


