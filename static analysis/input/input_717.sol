struct YourStruct {
    uint x;
    string y;
}
function func(
    uint a,
    uint b,
    string memory c,
    YourStruct memory d
    ) external;

let args = [
    1,
    2,
    "c",
    {
        x: 3,
        y: "y"
    }
]
contract.func(...args);


