struct Country {
  uint a;
  uint b;
  string c;
}

expect(await contract.getACountry("FR")).to.have.member([1, 2, "FR"])


