const source = fs.readFileSync(inboxPath, 'utf8');

console.log(solc.compile(source, 1));

<Buffer 54 65 73 74 69 6e 67 20 4e 6f 64 65 2e 6a 73 20 72 65 61 64 46 69 6c 65 28 29>

console.log(solc.compile(source, 1));

const source = fs.readFileSync(inboxPath, 'utf8');

const inboxPath = path.resolve(__dirname, 'contracts', 'Inbox.sol');
const source = fs.readFileSync(inboxPath, 'utf8');

console.log(solc.compile(source, 1));


