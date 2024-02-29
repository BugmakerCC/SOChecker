function exists1(uint num) public view returns (bool) {
    for (uint i = 0; i < numbers1.length; i++) {
        if (numbers1[i] == num) {
            return true;
        }
    }

    return false;
}

uint[] numbers1;
mapping(uint => bool) public exists1; 

function push1(uint num1, uint num2, uint num3) public {
    numbers1.push(num1);
    numbers1.push(num2);
    numbers1.push(num3);

    exists1[num1] = true;
    exists1[num2] = true;
    exists1[num3] = true;
}


