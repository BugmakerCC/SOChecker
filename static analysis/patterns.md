### Reentrancy

### Access Control
To assess the presence of access control vulnerabilities within a program, we analyze two critical aspects:

1) Path Source: The primary concern here revolves around the use of ``tx.origin``, which identifies the original initiator of a transaction. This attribute consistently points to the account that initiated the transaction, rather than the immediate source of the current call, and is frequently misused for access control purposes. We examine the opcode for the presence of ``ORIGIN`` to ascertain if the program employs the ``tx.origin`` statement. The existence of this statement implies a potential vulnerability.
   

2) Path Destination: Our examination extends to whether the program employs the ``SELFDESTRUCT`` instruction. Upon detecting this instruction, we further investigate the execution path leading to it, specifically looking for the ``CALLER`` instruction, which serves as a verification of the contract caller's identity. The absence of the ``CALLER`` instruction on the path to ``SELFDESTRUCT`` is indicative of a vulnerability.

### Arithmetic Issues
To illustrate our detection methodology, let's consider the example of overflow. Upon encountering an ``ADD`` instruction, our first step involves validating the real number constraint to filter out scenarios that evidently do not lead to overflow. Subsequently, we incorporate a specific constraint into the solver, namely ``UGT(first, computed)``, to assess whether first exceeds computed when dealing with unsigned integers. A positive result from this test signals the presence of an integer overflow. The underflow detection logic follows a similar approach.

### Unchecked Return Values
Smart contracts typically execute external calls using the ``CALL`` instruction. We examine the opcode for occurrences of the ``CALL`` instruction. Upon finding one, we further investigate whether the execution path subsequent to the CALL instruction includes a check for the value returned by ``CALL`` using the ``ISZERO`` instruction. The absence of such a check indicates a potential vulnerability, as it suggests that the contract may not properly handle the failure of external calls.

### Denial of Service
Our initial step involves analyzing the CFG for loops, which suggests the presence of loops between the program blocks. Subsequently, we scrutinize whether the loop's execution path involves operations that consume gas. If affirmative, the SMT solver attempts to simulate an execution path in which the contract function halts prematurely due to gas depletion, preventing the completion of the intended operations. A successful simulation of such a path under these criteria is indicative of a *DoS* vulnerability within the program.

### Bad Randomness

### Front Running

### Time Manipulation
In smart contracts, certain transactions depend on temporal elements or the sequencing of blocks, which miners can potentially manipulate. Consequently, opcodes related to time pose a vulnerability risk due to the possibility of malicious exploitation. Our detection focuses on identifying the use of ``BLOCKHASH``, ``TIMESTAMP``, and ``NUMBER`` instructions within the contract's code. The presence of any of these instructions is flagged as a potential vulnerability, indicating the contract's susceptibility to time-based manipulation risks.

### Short Address Attack
For *Short Address Attack*, we employ regular expression matching techniques within the source code to identify and flag abnormal addresses. We detect addresses that meet the following conditions: 1) Comply with the *EIP-55* rules. 2) Start with "0x", followed by 40 hexadecimal characters. 3) End with one or more "0".