pragma solidity >=0.4.22 <0.9.0;
struct list{
    string Pan;
    uint age;
    address Address;
    bool Enrolled;
    bool voted;
} 
struct candidate_list{
    string Name;
    address Address;
    uint id;
    bool listed;
}
address constant election_officer = address(0);
string constant decimal = "0";
uint constant totalSupply = 1000e18;
address constant founder = address(0);


