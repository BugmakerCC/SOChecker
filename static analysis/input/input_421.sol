compilesFiles = JSON.parse(solc.compile(JSON.stringify(input))).contracts[
'Inbox.sol'
].Inbox;

compilesFiles = JSON.parse(solc.compile(JSON.stringify(input))).contracts[
'Inbox.sol'
].basic;

const path = require('path');
const fs = require('fs');
const solc = require('solc');
const fsExtra = require('fs-extra')
 
const inboxPath = path.resolve(__dirname, 'contracts', 'Inbox.sol');
const source = fs.readFileSync(inboxPath, 'utf8');
 
const input = {
    language: 'Solidity',
    sources: {
        'Inbox.sol': {
            content: source,
        },
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ['*'],
            },
        },
    },
};

function writeOutput(compiled, buildPath) {
    fsExtra.ensureDirSync(buildPath);

    for (let contractFileName in compiled.contracts) {
        const contractName = contractFileName.replace('.sol', '');
        console.log('Writing: ', contractName + '.json');
        fsExtra.outputJsonSync(
            path.resolve(buildPath, contractName + '.json'),
            compiled.contracts[contractFileName].basic
        );
    }
}
 
 
compilesFiles = JSON.parse(solc.compile(JSON.stringify(input)));
const buildPath = path.resolve(__dirname, 'build');
writeOutput(compilesFiles, buildPath);


