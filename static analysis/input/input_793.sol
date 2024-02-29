contract Temp{

    MainContract main;

    constructor(MainContract _main) {
        main = _main;
    }
    

    function getData(uint number) public view returns(string memory){
        return main.get(number);
    }
}


