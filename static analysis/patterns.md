### &#8227; Reentrancy

Key Instruction: CALL SSTORE

Key Information: CFG path condition, Storage

Detection Process: Firstly, filter the contract for payable transfer functions through AST syntax tree function information. If none are found, proceed to the next step; if found, proceed to the next step. After completing the CFG construction, check if there are any `CALL` instructions in the blocks. If none are found, skip directly; if found, check if there is permission control upon entering this block. If there is, skip; if not, proceed to the next step. Traverse the CFG to obtain all subsequent paths of the block. If these subsequent paths do not contain `SSTORE` instructions, skip; if found, proceed to the next step. Use Storage information to retrieve the value saved by the `SSTORE` instruction and check if this value participates in the path selection entering the `CALL` block. If it does, consider it as reentrancy.

### &#8227; Access Control

Key Instruction: SELFDSETRUCT ORIGIN EQ

Key Information: CFG Storage

Detection Process: Access control focuses on detecting the misuse of unprotected key instructions (`SELFDESTRUCT`) and proxy instructions (`ORIGIN`). For the former, first, filter whether there is a *selfdestruct* function in the contract through the AST syntax tree. Then, after the CFG is built, traverse the blocks to find if they contain the `SELFDESTRUCT` instruction. If none of them contain it, skip; if they do, proceed to the next step. Detect whether the path selection entering this block has permission control (whether there is a comparison of memory information and caller address). If yes, skip; if not, consider it a vulnerability. For the latter, mainly detect whether the operands of the `EQ` instruction in the process of building CFG are respectively the proxy address and the caller address introduced by the `ORIGIN` instruction. If so, it is considered misuse of `ORIGIN`.

### &#8227; Arithmetic Issues

Key Instruction: ADD SUB

Key Information: CFG Storage

Detection Process: The detection process for `ADD` instruction corresponds to integer overflow, while the detection process for `SUB` instruction corresponds to integer underflow. The process is similar; here we will discuss integer overflow. Firstly, check if the left and right operands contain literals. If they do, skip; combine with memory information to check if the left and right operand expressions contain hash operations. If they do, skip. Finally, check if the corresponding constraints are met: `ADD` instruction corresponds to `UGT` (first, result), `SUB` instruction corresponds to `UGT` (second, first). If the above conditions are met, it is considered an arithmetic issue.

### &#8227; Unchecked Return Values

Key Instruction: CALL ISZERO

Key Information: CFG path condition, Storage 

Detection Process: Firstly, filter the contract for payable transfer functions through AST syntax tree function information. If none are found, skip directly; if found, proceed to the next step. After completing the CFG construction, check if there are any `CALL` instructions in the blocks. If none are found, skip directly. Traverse the CFG to obtain all subsequent paths of the block. For each block in the path, check if the return value of the `CALL` instruction participates in the path selection of that block. If it does, skip directly; if not, proceed to the next step. Check if the block contains an `ISZERO` instruction, and simultaneously check if the return value of the `CALL` instruction participates in the operation of `ISZERO` instruction as an operand. If it does, skip. If all the above conditions are met, it is considered a vulnerability of unchecked low-level call return values.

### &#8227; Denial of Service

Key Instruction: CALL

Key Information: CFG

Detection Process: Firstly, filter the contract for payable transfer functions through AST syntax tree function information. If none are found, skip directly; if found, proceed to the next step. After completing the CFG construction, detect if there are any cycles in the jumps between blocks using topological sorting. If none are found, skip; if there are, proceed to the next step. Utilize depth-first search to extract the cyclic nodes from the previously obtained topological sorting sequence, then check if the blocks corresponding to these cyclic nodes contain `CALL` instructions. If they do, it is considered a denial-of-service vulnerability.

### &#8227; Bad Randomness

Key Instruction: SHA MSTORE MLOAD TIMESTAMP NUMBER DIFFICULTY

Key Information: CFG Memory

Detection Process: Firstly, filter the contract for keccak256 hash functions using AST syntax tree function information. If none are found, skip directly; if found, proceed to the next step. Since the `SHA3` instruction calculates hashes by reading data from Memory, it's crucial to accurately store and identify data containing key information using `MSTORE` and `MLOAD`. Here, a Memory segmentation model is adopted, utilizing triplets {start, end, symbolic variable} to identify and memorize a segment of symbolic memory. By using the starting position and length popped from the stack by the `SHA3` instruction, the data covered by the triplet can be read. If the expression of the symbolic variable read contains data introduced by `TIMESTAMP`, `NUMBER`, or `DIFFICULTY` instructions, it is considered a Bad Randomness vulnerability.

### &#8227; Front Running

Key Instruction: CALL

Key Information: CFG

Detection Process: During the CFG construction process, different paths of fund flow are constructed based on the amount and destination address of transfers returned by `CALL` instructions. After the CFG construction is completed, each fund flow is compared against others. The detection aims to identify if there are paths with identical fund flows but different routes. If none are found, skip; if there are, it is considered a front-running vulnerability.

### &#8227; Time Manipulation

Key Instruction: TIMESTAMP NUMBER DIFFICULTY GT LT EQ

Key Information: CFG path condition

Detection Process: During the CFG construction process, check if the `GT`, `LT`, `EQ` instructions contain symbolic variables introduced by `TIMESTAMP`, `NUMBER`, and `DIFFICULTY` instructions. After completing the CFG construction, check if all path conditions contain symbolic variables introduced by `TIMESTAMP`, `NUMBER`, `DIFFICULTY`, and similar instructions. If neither of these conditions is met, skip; if either condition is met, it is considered a time manipulation vulnerability.

### &#8227; Short Address Attack

Detection Process: Scan the text to detect whether there is information that matches the *ERC20* short address but is less than 20 characters long. If none is found, skip; if there is, it is considered a short address attack.