pragma solidity ^0.8.9;
contract CarShop {
    address owner;
    uint256 toyotaCount;
    uint256 audiCount;
    uint256 bmwCount;

    Cars public toyota;
    Cars public audi;
    Cars public bmw;

    enum CarType {Toyota, Audi, Bmw}

    struct Cars {
        CarType carType;
        uint count;
    }

    constructor(uint256 _toyotaCount, uint256 _audiCount, uint256 _bmwCount) {
        owner = msg.sender;
        toyotaCount = _toyotaCount;
        audiCount = _audiCount;
        bmwCount = _bmwCount;

        toyota = Cars(CarType.Toyota, _toyotaCount);
        audi = Cars(CarType.Audi, _audiCount);
        bmw = Cars(CarType.Bmw, _bmwCount);
    }

    
    function addCarCount(CarType _carType, uint256 _count) public {
        require(msg.sender == owner, "Only owner can add car count");
        if(_carType == CarType.Toyota) {
            toyota.count += _count;
        } else if(_carType == CarType.Audi) {
            audi.count += _count;
        } else if(_carType == CarType.Bmw) {
            bmw.count += _count;
        }
    }
}

