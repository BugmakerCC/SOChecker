import "contractYouWantToInteractWith.sol";

contract Interact {
    contractYouWantToInteractWith public contract = contractYouWantToInteractWith(addressOfTheContract);


    function interact() public {
        contract.FUNCTIONFROMTHECONTRACT(inputs);
    }

}


