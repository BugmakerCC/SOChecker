const DEFAULT_COMPILER_SETTINGS = {
  version: '0.8.8',
}

const LOWEST_OPTIMIZER_COMPILER_SETTINGS = {
  version: '0.6.0',
  settings: {
    evmVersion: 'istanbul',
    optimizer: {
      enabled: true,
      runs: 1_000,
    },
    metadata: {
      bytecodeHash: 'none',
    },
  },
}

solidity: {
    compilers: [DEFAULT_COMPILER_SETTINGS],
    overrides: {
      'contracts/MockV3Aggregator.sol': LOW_OPTIMIZER_COMPILER_SETTINGS,
     
    },
  },

pragma solidity >=0.7.0 <0.9.0;


