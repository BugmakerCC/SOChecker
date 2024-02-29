await tether.approve(decentralbank.address, tokens("100"), {
  from: customer,
});

await decentralbank.stakeTokens(tokens("100"), {
  from: customer,
});


