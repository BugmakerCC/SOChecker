       pragma solidity >0.5.0;
           contract Greeter {
                string public greeting;
                constructor() public {
                    greeting = 'Hello';
                }
                function setGreeting(string memory _greeting) public {
                    greeting = _greeting;
                }
                function greet() view public returns (string memory) {
                    return greeting;
                }
         }

    from brownie import accounts, Greeter
    
    def interactions():
        account = accounts[0]
        contractObj = Greeter.deploy({"from": account})
        transaction = contractObj.setGreeting(Hola, {"from": account})
        transaction.wait(1)
        updatedGreeter = contractObj.greet()
        print(updatedGreeter)
    
    def main()
        interactions()


