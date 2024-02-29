bool private paused;
string tokenName;
 mapping(address=>mapping(address=>uint)) public allowed;

emit Burn(_from,_to,_tokens)

address payable public owner; 
constructor() { 
        owner = payable(msg.sender); 
    }
     

function renounceOwnership() external onlyOwner { 
        emit OwnershipRenounced(owner); 
        owner = payable(address(0)); 
    }

function transferOwnership(address _newOwner) external onlyOwner { 
        require(_newOwner != address(0)); 
        emit OwnershipTransferred(owner, _newOwner); 
        owner = payable(_newOwner); 
    } 

function updateOwner(address _newOwner) external onlyOwner { 
        require(_newOwner != address(0)); 
        emit OwnershipTransferred(owner, _newOwner); 
        owner = payable(_newOwner); 
    }


