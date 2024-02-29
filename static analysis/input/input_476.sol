    function getAllData() public view returns (People[] memory) {
        uint256 count = countArr.length;
        People[] memory outputL = new People[](count);

        while(count > 0) {
            count--;
            (string memory nam, uint256 num) = getPerson(countArr[count]);
            People memory temp = People(nam, num);
            outputL[count] = temp;
        }

        return outputL;
    } 


