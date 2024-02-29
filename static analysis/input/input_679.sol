import "prb-math/contracts/PRBMathSD59x18.sol";

contract SimpleContract {

    using PRBMathSD59x18 for int256;

    function exponential_function(int256 x) public view returns (int256) {
        int256 z = 90000000000000000;      
        int256 a = 200000000000000000;     
        int256 b = 1080000000000000000;    
        int256 c = -10000000000000000000;  
        int256 d = 100000000000000000;     
        int256 _x = x * 1000000000000000000;
        int256 outcome = PRBMathSD59x18.mul(a, b.pow(PRBMathSD59x18.mul(z, _x) + c)) + d;
        return outcome;
    }
}


