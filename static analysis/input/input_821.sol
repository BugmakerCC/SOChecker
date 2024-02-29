import json
from web3 import Web3, HTTPProvider

# truffle development blockchain address
blockchain_address = 'http
#client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))

compiled_contract_path = 'build/contracts/FirstContract.json'
deployed_contract_address = '0x'

with open(compiled_contract_path) as file:
    contract_json = json.load(file) #load contract info as JSON
    contract_abi = contract_json['abi']

contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)

result = contract.functions.setValue(10).transact() #use transact to store value in blockchain
print(result)
print(result.hex())
message = contract.functions.getValue().call()
print(message)


abi = '[]'

message = contract.functions.getValue().call()


