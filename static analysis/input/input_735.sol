interface CheatCodes {
           function prank(address) external;    
 }
contract Test is DSTest {
   CheatCodes cheatCodes;
   function setUp() public {
       cheatCodes = CheatCodes(HEVM_ADDRESS);
   }
   
   function test() public {
       cheatCodes.prank(address(1337));
       address(contract).customFunction();
   }
}
        


