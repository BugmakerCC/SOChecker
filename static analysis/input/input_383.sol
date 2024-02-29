contract MyToken is ERC20, AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor() ERC20("MyToken", "TKN") {
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }

    function setupMinter(address minter, bool enabled) external onlyRole(ADMIN_ROLE) {
        require(minter != address(0), "!minter");
        if (enabled) _setupRole(MINTER_ROLE, minter);
        else _revokeRole(MINTER_ROLE, minter);   
    }

    function setupBurner(address burner, bool enabled) external onlyRole(ADMIN_ROLE) {
        require(burner != address(0), "!burner");
        if (enabled) _setupRole(BURNER_ROLE, burner);
        else _revokeRole(BURNER_ROLE, burner);   
    }    

    function isMinter(address minter) external view returns(bool) {
        return hasRole(MINTER_ROLE, minter);
    }

    function isBurner(address burner) external view returns(bool) {
        return hasRole(BURNER_ROLE, burner);
    }    
}


