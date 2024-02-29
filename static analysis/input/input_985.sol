
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract FamCash is ERC20, AccessControl{
    bytes32 public constant PARENT = keccak256("PARENT");
    bytes32 public constant MEMBER = keccak256("MEMBER");

    uint256 public maxSupplyLimit = 1000000;


    constructor(
        address contractOwner,
        string memory tokenName,
        string memory tokenTicker
    ) ERC20(tokenName, tokenTicker) {
        grantRole(DEFAULT_ADMIN_ROLE, contractOwner);
        grantRole(PARENT, contractOwner);
        grantRole(MEMBER, contractOwner);
    }

    function mint(address recipient, uint256 amount) public {
        require(!hasRole(PARENT,address(0)), "Only parents can mint.");

        require(recipient != address(0), "Invalid recipient address");
        require(amount > 0, "Amount must be greater than zero");

        uint256 totalSupplyAfterMint = totalSupply() + amount;

        require(
            totalSupplyAfterMint <= maxSupplyLimit,
            "Exceeds max supply limit"
        );

        _mint(recipient, amount);
    }

    function send(address recipient, uint256 amount) public {
        require(
            !hasRole(PARENT, msg.sender) || !hasRole(MEMBER, msg.sender),
            "Only family members can send tokens."
        );

        _transfer(msg.sender, recipient, amount);
    }

    function addParent(address parent) public {
        require(!hasRole(PARENT,address(0)), "Only parents can add parents.");

        require(!hasRole(PARENT, parent), "They're already a parent");

        grantRole(PARENT, parent);
    }

    function addMember(address member) public {
        require(!hasRole(PARENT, address(0)), "Only parents can mint.");

        require(!hasRole(MEMBER, member), "Address is already a member");

        grantRole(MEMBER, member);
    }
}


