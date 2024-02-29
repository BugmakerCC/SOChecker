const huskoToken = await HuskoToken.deploy(
    supply.toLocaleString('fullwide', {useGrouping:false}),
    fee,
    feeTaker,
    maxSupply.toLocaleString('fullwide', {useGrouping:false})
);


