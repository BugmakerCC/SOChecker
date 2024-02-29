pragma solidity ^0.8.9;
contract MoviePayment {
    struct Movie {
        uint price;
    }
    mapping(string => Movie) public movieInfo;
    mapping(string => address[]) public paidUsers;

    function addMovie(string memory _title, uint _price) public {
        Movie memory newMovie = Movie({
            price: _price
        });

        movieInfo[_title] = newMovie;
    }

    function pay(string memory _title) public payable {
        require(msg.value == movieInfo[_title].price, "Invalid price for the film");

        paidUsers[_title].push(msg.sender);
    }

    function getPaidUsers(string memory _title) public view returns(address[] memory) {
        return paidUsers[_title];
    }    
}

