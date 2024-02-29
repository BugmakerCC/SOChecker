constructor(address initialOwner) Ownable(initialOwner) ERC20(_tokenname, _tokensymbol) {
_owner = initialOwner;

constructor(address _themergeraddress, address _initialOwner) AssetAcquisition(_initialOwner) {
themergeraddress = _themergeraddress;


