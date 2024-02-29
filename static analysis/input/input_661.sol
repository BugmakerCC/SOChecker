function getAll() external pure returns (uint8, bool) {
    return (1, true);
}

const returnedValues = await contract.getAll(); 
const number = returnedValues[0];
const status = returnedValues[1];

function getAll() external pure returns (uint8 number, bool status) {
    return (1, true);
}

const returnedValues = await contract.getAll(); 
const number = returnedValues.number;
const status = returnedValues.status;


