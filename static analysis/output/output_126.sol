pragma solidity ^0.8;

contract MyContract {
  struct Strings {
    string[] s;
  }

  function foo() external pure {
    Strings[] memory strings = new Strings[](2);

    strings[0].s = new string[](2);
    strings[0].s[0] = "a";
    strings[0].s[1] = "b";

    strings[1].s = new string[](3);
    strings[1].s[0] = "a";
    strings[1].s[1] = "b";
    strings[1].s[1] = "c";
  }
}

