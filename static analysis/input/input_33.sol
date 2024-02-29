...
import "@openzeppelin/contracts/utils/Counters.sol";
...
error ExceededWhitelistSupply();
...
using Counters for Counters.Counter;
uint256 public maxSupply = 10000;
uint256 public maxWhitelistSupply = 1500;
Counters.Counter private totalWhitelistSupply;
...
function mintWhitelist(uint256 _qty) external payable {
  if ( totalWhitelistSupply.current() + _qty > maxWhitelistSupply ) revert ExceededWhitelistSupply();

  for (uint256 i = 0; i < _qty; i++) {
    totalWhitelistSupply.increment();
  }

  _mint(msg.sender, _qty, '', true);
}

...
import "@openzeppelin/contracts/utils/Counters.sol";
...
error ExceededWhitelistSupply();
error ExceededMaxPerWallet();
...
using Counters for Counters.Counter;
uint256 public maxSupply = 10000;
uint256 public maxWhitelistSupply = 1500;
uint256 public maxWhitelistPerWallet = 10;
Counters.Counter private totalWhitelistSupply;

mapping(address => uint256) public whitelistMintedAmount;
...
function mintWhitelist(uint256 _qty) external payable {
  if ( whitelistMintedAmount[msg.sender] + _qty > maxWhitelistPerWallet ) revert ExceededMaxPerWallet();
  if ( totalWhitelistSupply.current() + _qty > maxWhitelistSupply ) revert ExceededWhitelistSupply();

  for (uint256 i = 0; i < _qty; i++) {
    totalWhitelistSupply.increment();
  }

  whitelistMintedAmount[msg.sender] += _qty;
  _mint(msg.sender, _qty, '', true);
}


