contract testCatch{
    function GetTest() public view returns (string memory)  {
        address _token_addr = 0x406AB5033423Dcb6391Ac9eEEad73294FA82Cfbc;
       
        ERC165 candidateContract = ERC165(_token_addr);
        try candidateContract.supportsInterface(0x80ac58cd) {

             return "tried";
        }
        catch
        {
              return "catch";
        }  
}

}
interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
 
contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        require(2==3,"wrong calculation");
        return interfaceId == type(IERC165).interfaceId;
    }
}

contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}


