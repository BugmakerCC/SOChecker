contract Flags {
   string public flag = unicode"🇦🇩";

   function setFlag(string memory _flag) public {
       flag = _flag;
   }
}

from brownie import accounts, Flags

def test_unicode_string_setup():
    contract = Flags.deploy({'from': accounts[0]})
    assert contract.flag() == "🇦🇩"

    # no unicode keyword    
    contract.setFlag("🇦🇪", {'from': accounts[0]})
    assert contract.flag() == "🇦🇪"


