pragma solidity ^0.4.23;
contract MovieRating {
    address owner;
    struct Movie
    {
        string name;
        int16 releasedYear;
        string directedBy;
        string description;
    }
    
    struct MovieRating{
        int8 rating;
        string userName;
        string comments;
    }
    
    //Store movies in map: [Key:Movie] where key=name of movie
    mapping (string => Movie) _movieMap;
    
    //Rating map : key=name of movie
    mapping (string => MovieRating[]) movieRatingMap;
    
    constructor() public payable
    {
        owner = msg.sender;
         _movieMap["Jurassic Park"] = Movie("Jurassic Park", 1992, "Spillberg", "The Dinasor movie");
         _movieMap["Tomb Rider"] = Movie("Tomb Rider", 2018, "Jack", "The Tomb Rider");
         _movieMap["The MAtrix"] = Movie("The Matrix", 2018, "Daniel", "The Matrix");
    }
    
    
    function rateMovie(string movieName,
    int8 rating, string userName, string comments)
    external
    returns(bool)
    {
        
        movieRatingMap[movieName].push(MovieRating(rating, userName, comments));
        return true;
    }
    
    function getMovieRatingCount(string movieName)
    external
    view
    returns(uint)
    {
        MovieRating[] memory arrTemp = movieRatingMap[movieName];
        return arrTemp.length;
    }
    
    function kill() 
    public
    {
        require(msg.sender == owner);
        selfdestruct(owner);
    }
}