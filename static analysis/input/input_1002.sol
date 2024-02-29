
pragma solidity 0.8.7; 

contract Rating{

    string[] moviesList;

    mapping(string => uint8) movieRatings;

    constructor() {
        moviesList = ["movie1","movie2","movie3"]; 
    }

    function addMovie(string memory movie) public returns(string memory){
        moviesList.push(movie);
        return movie;
    }

    function getList() public view returns(string[] memory){ 
        return moviesList;
    }

    function rateMovie(string memory movie,uint8 rating) public {
        require(rating >=0 && rating <= 10,"rating is out of range");
        movieRatings[movie] = rating;
    }
    
    function getMovieRating(string memory movie) public view returns(uint8){
        return movieRatings[movie];
    }

}


