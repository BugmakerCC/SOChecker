contract CommitteePrecompiled {
    struct Node {
    }
    mapping (address => Node[]) userNodes;

    function RegisterNode() public {
        Node memory node = Node(
);
        userNodes[msg.sender].push(node);
    }

    function QueryState()   public view returns(string memory, int ) {
    }

}


