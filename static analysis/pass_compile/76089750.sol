contract CommitteePrecompiled {
    struct Node {
        // TODO params
    }
    mapping (address => Node[]) userNodes;

    function RegisterNode() public {
        Node memory node = Node(/* TODO params */);
        userNodes[msg.sender].push(node);
    }

    function QueryState()   public view returns(string memory, int ) {
        // TODO your code to retrieve the state and return a `string` and an `int`
    }

    // TODO implement all your functions
}

