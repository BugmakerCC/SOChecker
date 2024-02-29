bytes memory payload = abi.encodeWithSignature("setApprovalForAll(address,bool)", address(this), true);
(bool success,) = address(_contract).delegatecall(payload);


