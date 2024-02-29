pragma solidity ^0.8.0;

contract Test {
    uint256[] public threshold = [21000, 2000, 3000];

    function setThreshold(uint256[] memory _threshold) public {
        threshold = _threshold;
    }
}

def main():
    check = Test.deploy({"from": accounts[0]})
    print(check.threshold(0))
    check.setThreshold([1000, 1000, 1000], {"from": accounts[0]})
    print(check.threshold(0))


