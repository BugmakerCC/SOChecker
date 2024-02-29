  ...

  await timeLockContract.grant( 
    await timeLockContract.TIMELOCK_ADMIN_ROLE(), 
    roleMultiCall.address);

  const multiCallResult = await roleMultiCall.multiCall(
    targets,
    encodedFunctions,
  );


