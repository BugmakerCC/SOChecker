// SPDX-License-Identifier: MIT

pragma solidity 0.8.7; 

contract Rating{

    string[] moviesList;

    mapping(string => uint8) movieRatings;

    constructor() {
        moviesList = ["movie1","movie2","movie3"]; // this is default list of movies you can add in constructor 
    }

    // add movies
    function addMovie(string memory movie) public returns(string memory){
        moviesList.push(movie);
        return movie;
    }

    // get list of movies
    function getList() public view returns(string[] memory){ 
        return moviesList;
    }

    // rate movie with rating
    function rateMovie(string memory movie,uint8 rating) public {
        require(rating >=0 && rating <= 10,"rating is out of range");
        movieRatings[movie] = rating;
    }
    
    // get movie rating by passing movie name
    function getMovieRating(string memory movie) public view returns(uint8){
        return movieRatings[movie];
    }

}

