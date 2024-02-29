contract VANET {
Vehicle[] vehicles;

struct Vehicle{
    string name;
    string owner; 
    string number; 
    string license;
}

event VehicleEvent(
    string name,
    string owner,
    string number,
    string license
);

function setVehicle(string memory _name, string memory _owner, string memory _number, string memory _license) public{
    vehicles.push(Vehicle(_name, _owner, _number, _license));
    emit VehicleEvent(_name, _owner, _number, _license);
}

function getVehicle(uint256 id) public view returns (string memory name, string memory owner, string memory number, string memory license) {
    return (vehicles[id].name, vehicles[id].owner, vehicles[id].number, vehicles[id].license);
}}

