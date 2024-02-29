// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MappingInFunction {
    mapping (uint => string) public Names;
    uint public counter;
   
    function addToMappingInsideFunction(string memory name) public returns (string memory localName)  {
        mapping (uint => string) storage localNames = Names;
        counter+=1;
        localNames[counter] = name;
        return localNames[counter];

        // we cannot return mapping in solidity
        // return localNames;
}

}

.code
  PUSH 80			contract MappingInFunction {\r...
  PUSH 40			contract MappingInFunction {\r...
  MSTORE 			contract MappingInFunction {\r...
  CALLVALUE 			contract MappingInFunction {\r...
  DUP1 			contract MappingInFunction {\r...
  ISZERO 			contract MappingInFunction {\r...
  PUSH [tag] 1			contract MappingInFunction {\r...
  JUMPI 			contract MappingInFunction {\r...
  PUSH 0			contract MappingInFunction {\r...
  DUP1 			contract MappingInFunction {\r...
  REVERT 			contract MappingInFunction {\r...
tag 1			contract MappingInFunction {\r...
  JUMPDEST 			contract MappingInFunction {\r...
  POP 			contract MappingInFunction {\r...
  PUSH #[$] 0000000000000000000000000000000000000000000000000000000000000000			contract MappingInFunction {\r...
  DUP1 			contract MappingInFunction {\r...
  PUSH [$] 0000000000000000000000000000000000000000000000000000000000000000			contract MappingInFunction {\r...
  PUSH 0			contract MappingInFunction {\r...
  CODECOPY 			contract MappingInFunction {\r...
  PUSH 0			contract MappingInFunction {\r...
  RETURN 			contract MappingInFunction {\r...
.data
  0:
    .code
      PUSH 80			contract MappingInFunction {\r...
      PUSH 40			contract MappingInFunction {\r...
      MSTORE 			contract MappingInFunction {\r...
      CALLVALUE 			contract MappingInFunction {\r...
      DUP1 			contract MappingInFunction {\r...
      ISZERO 			contract MappingInFunction {\r...
      PUSH [tag] 1			contract MappingInFunction {\r...
      JUMPI 			contract MappingInFunction {\r...
      PUSH 0			contract MappingInFunction {\r...
      DUP1 			contract MappingInFunction {\r...
      REVERT 			contract MappingInFunction {\r...
    tag 1			contract MappingInFunction {\r...
      JUMPDEST 			contract MappingInFunction {\r...
      POP 			contract MappingInFunction {\r...
      PUSH 4			contract MappingInFunction {\r...
      CALLDATASIZE 			contract MappingInFunction {\r...
      LT 			contract MappingInFunction {\r...
      PUSH [tag] 2			contract MappingInFunction {\r...
      JUMPI 			contract MappingInFunction {\r...
      PUSH 0			contract MappingInFunction {\r...
      CALLDATALOAD 			contract MappingInFunction {\r...
      PUSH E0			contract MappingInFunction {\r...
      SHR 			contract MappingInFunction {\r...
      DUP1 			contract MappingInFunction {\r...
      PUSH 61BC221A			contract MappingInFunction {\r...
      EQ 			contract MappingInFunction {\r...
      PUSH [tag] 3			contract MappingInFunction {\r...
      JUMPI 			contract MappingInFunction {\r...
      DUP1 			contract MappingInFunction {\r...
      PUSH 731FD880			contract MappingInFunction {\r...
      EQ 			contract MappingInFunction {\r...
      PUSH [tag] 4			contract MappingInFunction {\r...
      JUMPI 			contract MappingInFunction {\r...
      DUP1 			contract MappingInFunction {\r...
      PUSH F01A4E0E			contract MappingInFunction {\r...
      EQ 			contract MappingInFunction {\r...
      PUSH [tag] 5			contract MappingInFunction {\r...
      JUMPI 			contract MappingInFunction {\r...
    tag 2			contract MappingInFunction {\r...
      JUMPDEST 			contract MappingInFunction {\r...
      PUSH 0			contract MappingInFunction {\r...
      DUP1 			contract MappingInFunction {\r...
      REVERT 			contract MappingInFunction {\r...
    tag 3			uint public counter
      JUMPDEST 			uint public counter
      PUSH [tag] 6			uint public counter
      PUSH [tag] 7			uint public counter
      JUMP 			uint public counter
    tag 6			uint public counter
      JUMPDEST 			uint public counter
      PUSH 40			uint public counter
      MLOAD 			uint public counter
      PUSH [tag] 8			uint public counter
      SWAP2 			uint public counter
      SWAP1 			uint public counter
      PUSH [tag] 9			uint public counter
      JUMP 			uint public counter
    tag 8			uint public counter
      JUMPDEST 			uint public counter
      PUSH 40			uint public counter
      MLOAD 			uint public counter
      DUP1 			uint public counter
      SWAP2 			uint public counter
      SUB 			uint public counter
      SWAP1 			uint public counter
      RETURN 			uint public counter
    tag 4			function addToMappingInsideFun...
      JUMPDEST 			function addToMappingInsideFun...
      PUSH [tag] 10			function addToMappingInsideFun...
      PUSH 4			function addToMappingInsideFun...
      DUP1 			function addToMappingInsideFun...
      CALLDATASIZE 			function addToMappingInsideFun...
      SUB 			function addToMappingInsideFun...
      DUP2 			function addToMappingInsideFun...
      ADD 			function addToMappingInsideFun...
      SWAP1 			function addToMappingInsideFun...
      PUSH [tag] 11			function addToMappingInsideFun...
      SWAP2 			function addToMappingInsideFun...
      SWAP1 			function addToMappingInsideFun...
      PUSH [tag] 12			function addToMappingInsideFun...
      JUMP 			function addToMappingInsideFun...
    tag 11			function addToMappingInsideFun...
      JUMPDEST 			function addToMappingInsideFun...
      PUSH [tag] 13			function addToMappingInsideFun...
      JUMP 			function addToMappingInsideFun...
    tag 10			function addToMappingInsideFun...
      JUMPDEST 			function addToMappingInsideFun...
      PUSH 40			function addToMappingInsideFun...
      MLOAD 			function addToMappingInsideFun...
      PUSH [tag] 14			function addToMappingInsideFun...
      SWAP2 			function addToMappingInsideFun...
      SWAP1 			function addToMappingInsideFun...
      PUSH [tag] 15			function addToMappingInsideFun...
      JUMP 			function addToMappingInsideFun...
    tag 14			function addToMappingInsideFun...
      JUMPDEST 			function addToMappingInsideFun...
      PUSH 40			function addToMappingInsideFun...
      MLOAD 			function addToMappingInsideFun...
      DUP1 			function addToMappingInsideFun...
      SWAP2 			function addToMappingInsideFun...
      SUB 			function addToMappingInsideFun...
      SWAP1 			function addToMappingInsideFun...
      RETURN 			function addToMappingInsideFun...
    tag 5			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      PUSH [tag] 16			mapping (uint => string) publi...
      PUSH 4			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      CALLDATASIZE 			mapping (uint => string) publi...
      SUB 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH [tag] 17			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH [tag] 18			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 17			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      PUSH [tag] 19			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 16			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      PUSH 40			mapping (uint => string) publi...
      MLOAD 			mapping (uint => string) publi...
      PUSH [tag] 20			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH [tag] 15			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 20			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      PUSH 40			mapping (uint => string) publi...
      MLOAD 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      SUB 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      RETURN 			mapping (uint => string) publi...
    tag 7			uint public counter
      JUMPDEST 			uint public counter
      PUSH 1			uint public counter
      SLOAD 			uint public counter
      DUP2 			uint public counter
      JUMP 			uint public counter
    tag 13			function addToMappingInsideFun...
      JUMPDEST 			function addToMappingInsideFun...
      PUSH 60			string memory localName
      PUSH 0			mapping (uint => string) stora...
      PUSH 1			1
      DUP1 			counter
      PUSH 0			counter
      DUP3 			counter+=1
      DUP3 			counter+=1
      SLOAD 			counter+=1
      PUSH [tag] 22			counter+=1
      SWAP2 			counter+=1
      SWAP1 			counter+=1
      PUSH [tag] 23			counter+=1
      JUMP 			counter+=1
    tag 22			counter+=1
      JUMPDEST 			counter+=1
      SWAP3 			counter+=1
      POP 			counter+=1
      POP 			counter+=1
      DUP2 			counter+=1
      SWAP1 			counter+=1
      SSTORE 			counter+=1
      POP 			counter+=1
      DUP3 			name
      DUP2 			localNames
      PUSH 0			localNames[counter]
      PUSH 1			counter
      SLOAD 			counter
      DUP2 			localNames[counter]
      MSTORE 			localNames[counter]
      PUSH 20			localNames[counter]
      ADD 			localNames[counter]
      SWAP1 			localNames[counter]
      DUP2 			localNames[counter]
      MSTORE 			localNames[counter]
      PUSH 20			localNames[counter]
      ADD 			localNames[counter]
      PUSH 0			localNames[counter]
      KECCAK256 			localNames[counter]
      SWAP1 			localNames[counter] = name
      DUP2 			localNames[counter] = name
      PUSH [tag] 24			localNames[counter] = name
      SWAP2 			localNames[counter] = name
      SWAP1 			localNames[counter] = name
      PUSH [tag] 25			localNames[counter] = name
      JUMP 			localNames[counter] = name
    tag 24			localNames[counter] = name
      JUMPDEST 			localNames[counter] = name
      POP 			localNames[counter] = name
      DUP1 			localNames
      PUSH 0			localNames[counter]
      PUSH 1			counter
      SLOAD 			counter
      DUP2 			localNames[counter]
      MSTORE 			localNames[counter]
      PUSH 20			localNames[counter]
      ADD 			localNames[counter]
      SWAP1 			localNames[counter]
      DUP2 			localNames[counter]
      MSTORE 			localNames[counter]
      PUSH 20			localNames[counter]
      ADD 			localNames[counter]
      PUSH 0			localNames[counter]
      KECCAK256 			localNames[counter]
      DUP1 			return localNames[counter]
      SLOAD 			return localNames[counter]
      PUSH [tag] 26			return localNames[counter]
      SWAP1 			return localNames[counter]
      PUSH [tag] 27			return localNames[counter]
      JUMP 			return localNames[counter]
    tag 26			return localNames[counter]
      JUMPDEST 			return localNames[counter]
      DUP1 			return localNames[counter]
      PUSH 1F			return localNames[counter]
      ADD 			return localNames[counter]
      PUSH 20			return localNames[counter]
      DUP1 			return localNames[counter]
      SWAP2 			return localNames[counter]
      DIV 			return localNames[counter]
      MUL 			return localNames[counter]
      PUSH 20			return localNames[counter]
      ADD 			return localNames[counter]
      PUSH 40			return localNames[counter]
      MLOAD 			return localNames[counter]
      SWAP1 			return localNames[counter]
      DUP2 			return localNames[counter]
      ADD 			return localNames[counter]
      PUSH 40			return localNames[counter]
      MSTORE 			return localNames[counter]
      DUP1 			return localNames[counter]
      SWAP3 			return localNames[counter]
      SWAP2 			return localNames[counter]
      SWAP1 			return localNames[counter]
      DUP2 			return localNames[counter]
      DUP2 			return localNames[counter]
      MSTORE 			return localNames[counter]
      PUSH 20			return localNames[counter]
      ADD 			return localNames[counter]
      DUP3 			return localNames[counter]
      DUP1 			return localNames[counter]
      SLOAD 			return localNames[counter]
      PUSH [tag] 28			return localNames[counter]
      SWAP1 			return localNames[counter]
      PUSH [tag] 27			return localNames[counter]
      JUMP 			return localNames[counter]
    tag 28			return localNames[counter]
      JUMPDEST 			return localNames[counter]
      DUP1 			return localNames[counter]
      ISZERO 			return localNames[counter]
      PUSH [tag] 29			return localNames[counter]
      JUMPI 			return localNames[counter]
      DUP1 			return localNames[counter]
      PUSH 1F			return localNames[counter]
      LT 			return localNames[counter]
      PUSH [tag] 30			return localNames[counter]
      JUMPI 			return localNames[counter]
      PUSH 100			return localNames[counter]
      DUP1 			return localNames[counter]
      DUP4 			return localNames[counter]
      SLOAD 			return localNames[counter]
      DIV 			return localNames[counter]
      MUL 			return localNames[counter]
      DUP4 			return localNames[counter]
      MSTORE 			return localNames[counter]
      SWAP2 			return localNames[counter]
      PUSH 20			return localNames[counter]
      ADD 			return localNames[counter]
      SWAP2 			return localNames[counter]
      PUSH [tag] 29			return localNames[counter]
      JUMP 			return localNames[counter]
    tag 30			return localNames[counter]
      JUMPDEST 			return localNames[counter]
      DUP3 			return localNames[counter]
      ADD 			return localNames[counter]
      SWAP2 			return localNames[counter]
      SWAP1 			return localNames[counter]
      PUSH 0			return localNames[counter]
      MSTORE 			return localNames[counter]
      PUSH 20			return localNames[counter]
      PUSH 0			return localNames[counter]
      KECCAK256 			return localNames[counter]
      SWAP1 			return localNames[counter]
    tag 31			return localNames[counter]
      JUMPDEST 			return localNames[counter]
      DUP2 			return localNames[counter]
      SLOAD 			return localNames[counter]
      DUP2 			return localNames[counter]
      MSTORE 			return localNames[counter]
      SWAP1 			return localNames[counter]
      PUSH 1			return localNames[counter]
      ADD 			return localNames[counter]
      SWAP1 			return localNames[counter]
      PUSH 20			return localNames[counter]
      ADD 			return localNames[counter]
      DUP1 			return localNames[counter]
      DUP4 			return localNames[counter]
      GT 			return localNames[counter]
      PUSH [tag] 31			return localNames[counter]
      JUMPI 			return localNames[counter]
      DUP3 			return localNames[counter]
      SWAP1 			return localNames[counter]
      SUB 			return localNames[counter]
      PUSH 1F			return localNames[counter]
      AND 			return localNames[counter]
      DUP3 			return localNames[counter]
      ADD 			return localNames[counter]
      SWAP2 			return localNames[counter]
    tag 29			return localNames[counter]
      JUMPDEST 			return localNames[counter]
      POP 			return localNames[counter]
      POP 			return localNames[counter]
      POP 			return localNames[counter]
      POP 			return localNames[counter]
      POP 			return localNames[counter]
      SWAP2 			return localNames[counter]
      POP 			return localNames[counter]
      POP 			return localNames[counter]
      SWAP2 			function addToMappingInsideFun...
      SWAP1 			function addToMappingInsideFun...
      POP 			function addToMappingInsideFun...
      JUMP 			function addToMappingInsideFun...
    tag 19			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      PUSH 0			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      PUSH 0			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      PUSH 40			mapping (uint => string) publi...
      PUSH 0			mapping (uint => string) publi...
      KECCAK256 			mapping (uint => string) publi...
      PUSH 0			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      SLOAD 			mapping (uint => string) publi...
      PUSH [tag] 32			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH [tag] 27			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 32			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      PUSH 1F			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      DIV 			mapping (uint => string) publi...
      MUL 			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      PUSH 40			mapping (uint => string) publi...
      MLOAD 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      PUSH 40			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      SWAP3 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      DUP3 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      SLOAD 			mapping (uint => string) publi...
      PUSH [tag] 33			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH [tag] 27			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 33			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      ISZERO 			mapping (uint => string) publi...
      PUSH [tag] 34			mapping (uint => string) publi...
      JUMPI 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      PUSH 1F			mapping (uint => string) publi...
      LT 			mapping (uint => string) publi...
      PUSH [tag] 35			mapping (uint => string) publi...
      JUMPI 			mapping (uint => string) publi...
      PUSH 100			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      DUP4 			mapping (uint => string) publi...
      SLOAD 			mapping (uint => string) publi...
      DIV 			mapping (uint => string) publi...
      MUL 			mapping (uint => string) publi...
      DUP4 			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      PUSH [tag] 34			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 35			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      DUP3 			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH 0			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      PUSH 0			mapping (uint => string) publi...
      KECCAK256 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
    tag 36			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      SLOAD 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      MSTORE 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH 1			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      PUSH 20			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      DUP1 			mapping (uint => string) publi...
      DUP4 			mapping (uint => string) publi...
      GT 			mapping (uint => string) publi...
      PUSH [tag] 36			mapping (uint => string) publi...
      JUMPI 			mapping (uint => string) publi...
      DUP3 			mapping (uint => string) publi...
      SWAP1 			mapping (uint => string) publi...
      SUB 			mapping (uint => string) publi...
      PUSH 1F			mapping (uint => string) publi...
      AND 			mapping (uint => string) publi...
      DUP3 			mapping (uint => string) publi...
      ADD 			mapping (uint => string) publi...
      SWAP2 			mapping (uint => string) publi...
    tag 34			mapping (uint => string) publi...
      JUMPDEST 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      POP 			mapping (uint => string) publi...
      DUP2 			mapping (uint => string) publi...
      JUMP 			mapping (uint => string) publi...
    tag 37			-License-Identifier: GPL-3.0\r...
      JUMPDEST 			-License-Identifier: GPL-3.0\r...
      PUSH 0			solidit
      DUP2 			ontra
      SWAP1 			0.9.0;\r\n\r\ncontra
      POP 			0.9.0;\r\n\r\ncontra
      SWAP2 			-License-Identifier: GPL-3.0\r...
      SWAP1 			-License-Identifier: GPL-3.0\r...
      POP 			-License-Identifier: GPL-3.0\r...
      JUMP 			-License-Identifier: GPL-3.0\r...
    tag 38			Function {\r\n    mapping (uin...
      JUMPDEST 			Function {\r\n    mapping (uin...
      PUSH [tag] 78			    function addToMappin
      DUP2 			Mappi
      PUSH [tag] 37			    function addToMappin
      JUMP 			    function addToMappin
    tag 78			    function addToMappin
      JUMPDEST 			    function addToMappin
      DUP3 			   
      MSTORE 			nter;\r\n   \r\n    function a...
      POP 			Function {\r\n    mapping (uin...
      POP 			Function {\r\n    mapping (uin...
      JUMP 			Function {\r\n    mapping (uin...
    tag 9			on(string memory name) public ...
      JUMPDEST 			on(string memory name) public ...
      PUSH 0			stri
      PUSH 20			  
      DUP3 			= Names;\r
      ADD 			mes = Names;\r\n    
      SWAP1 			 localNames = Names;\r\n    
      POP 			 localNames = Names;\r\n    
      PUSH [tag] 80			r+=1;\r\n        localNames[co...
      PUSH 0			s
      DUP4 			n localNa
      ADD 			eturn localNames[
      DUP5 			      
      PUSH [tag] 38			r+=1;\r\n        localNames[co...
      JUMP 			r+=1;\r\n        localNames[co...
    tag 80			r+=1;\r\n        localNames[co...
      JUMPDEST 			r+=1;\r\n        localNames[co...
      SWAP3 			on(string memory name) public ...
      SWAP2 			on(string memory name) public ...
      POP 			on(string memory name) public ...
      POP 			on(string memory name) public ...
      JUMP 			on(string memory name) public ...
    tag 39			       // we cannot return map...
      JUMPDEST 			       // we cannot return map...
      PUSH 0			g in s
      PUSH 40			lo
      MLOAD 			eturn loc
      SWAP1 			      // return loc
      POP 			      // return loc
      SWAP1 			       // we cannot return map...
      JUMP 			       // we cannot return map...
    tag 40			\n\r\n}\r\n\r\n
      JUMPDEST 			\n\r\n}\r\n\r\n
      PUSH 0			
      DUP1 			
      REVERT 			
    tag 41			
      JUMPDEST 			
      PUSH 0			
      DUP1 			
      REVERT 			
    tag 42			
      JUMPDEST 			
      PUSH 0			
      DUP1 			
      REVERT 			
    tag 43			
      JUMPDEST 			
      PUSH 0			
      DUP1 			
      REVERT 			
    tag 44			
      JUMPDEST 			
      PUSH 0			
      PUSH 1F			
      NOT 			
      PUSH 1F			
      DUP4 			
      ADD 			
      AND 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 45			
      JUMPDEST 			
      PUSH 4E487B7100000000000000000000000000000000000000000000000000000000			
      PUSH 0			
      MSTORE 			
      PUSH 41			
      PUSH 4			
      MSTORE 			
      PUSH 24			
      PUSH 0			
      REVERT 			
    tag 46			
      JUMPDEST 			
      PUSH [tag] 89			
      DUP3 			
      PUSH [tag] 44			
      JUMP 			
    tag 89			
      JUMPDEST 			
      DUP2 			
      ADD 			
      DUP2 			
      DUP2 			
      LT 			
      PUSH FFFFFFFFFFFFFFFF			
      DUP3 			
      GT 			
      OR 			
      ISZERO 			
      PUSH [tag] 90			
      JUMPI 			
      PUSH [tag] 91			
      PUSH [tag] 45			
      JUMP 			
    tag 91			
      JUMPDEST 			
    tag 90			
      JUMPDEST 			
      DUP1 			
      PUSH 40			
      MSTORE 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 47			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 93			
      PUSH [tag] 39			
      JUMP 			
    tag 93			
      JUMPDEST 			
      SWAP1 			
      POP 			
      PUSH [tag] 94			
      DUP3 			
      DUP3 			
      PUSH [tag] 46			
      JUMP 			
    tag 94			
      JUMPDEST 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 48			
      JUMPDEST 			
      PUSH 0			
      PUSH FFFFFFFFFFFFFFFF			
      DUP3 			
      GT 			
      ISZERO 			
      PUSH [tag] 96			
      JUMPI 			
      PUSH [tag] 97			
      PUSH [tag] 45			
      JUMP 			
    tag 97			
      JUMPDEST 			
    tag 96			
      JUMPDEST 			
      PUSH [tag] 98			
      DUP3 			
      PUSH [tag] 44			
      JUMP 			
    tag 98			
      JUMPDEST 			
      SWAP1 			
      POP 			
      PUSH 20			
      DUP2 			
      ADD 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 49			
      JUMPDEST 			
      DUP3 			
      DUP2 			
      DUP4 			
      CALLDATACOPY 			
      PUSH 0			
      DUP4 			
      DUP4 			
      ADD 			
      MSTORE 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 50			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 101			
      PUSH [tag] 102			
      DUP5 			
      PUSH [tag] 48			
      JUMP 			
    tag 102			
      JUMPDEST 			
      PUSH [tag] 47			
      JUMP 			
    tag 101			
      JUMPDEST 			
      SWAP1 			
      POP 			
      DUP3 			
      DUP2 			
      MSTORE 			
      PUSH 20			
      DUP2 			
      ADD 			
      DUP5 			
      DUP5 			
      DUP5 			
      ADD 			
      GT 			
      ISZERO 			
      PUSH [tag] 103			
      JUMPI 			
      PUSH [tag] 104			
      PUSH [tag] 43			
      JUMP 			
    tag 104			
      JUMPDEST 			
    tag 103			
      JUMPDEST 			
      PUSH [tag] 105			
      DUP5 			
      DUP3 			
      DUP6 			
      PUSH [tag] 49			
      JUMP 			
    tag 105			
      JUMPDEST 			
      POP 			
      SWAP4 			
      SWAP3 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 51			
      JUMPDEST 			
      PUSH 0			
      DUP3 			
      PUSH 1F			
      DUP4 			
      ADD 			
      SLT 			
      PUSH [tag] 107			
      JUMPI 			
      PUSH [tag] 108			
      PUSH [tag] 42			
      JUMP 			
    tag 108			
      JUMPDEST 			
    tag 107			
      JUMPDEST 			
      DUP2 			
      CALLDATALOAD 			
      PUSH [tag] 109			
      DUP5 			
      DUP3 			
      PUSH 20			
      DUP7 			
      ADD 			
      PUSH [tag] 50			
      JUMP 			
    tag 109			
      JUMPDEST 			
      SWAP2 			
      POP 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 12			
      JUMPDEST 			
      PUSH 0			
      PUSH 20			
      DUP3 			
      DUP5 			
      SUB 			
      SLT 			
      ISZERO 			
      PUSH [tag] 111			
      JUMPI 			
      PUSH [tag] 112			
      PUSH [tag] 40			
      JUMP 			
    tag 112			
      JUMPDEST 			
    tag 111			
      JUMPDEST 			
      PUSH 0			
      DUP3 			
      ADD 			
      CALLDATALOAD 			
      PUSH FFFFFFFFFFFFFFFF			
      DUP2 			
      GT 			
      ISZERO 			
      PUSH [tag] 113			
      JUMPI 			
      PUSH [tag] 114			
      PUSH [tag] 41			
      JUMP 			
    tag 114			
      JUMPDEST 			
    tag 113			
      JUMPDEST 			
      PUSH [tag] 115			
      DUP5 			
      DUP3 			
      DUP6 			
      ADD 			
      PUSH [tag] 51			
      JUMP 			
    tag 115			
      JUMPDEST 			
      SWAP2 			
      POP 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 52			
      JUMPDEST 			
      PUSH 0			
      DUP2 			
      MLOAD 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 53			
      JUMPDEST 			
      PUSH 0			
      DUP3 			
      DUP3 			
      MSTORE 			
      PUSH 20			
      DUP3 			
      ADD 			
      SWAP1 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 54			
      JUMPDEST 			
      PUSH 0			
    tag 119			
      JUMPDEST 			
      DUP4 			
      DUP2 			
      LT 			
      ISZERO 			
      PUSH [tag] 121			
      JUMPI 			
      DUP1 			
      DUP3 			
      ADD 			
      MLOAD 			
      DUP2 			
      DUP5 			
      ADD 			
      MSTORE 			
      PUSH 20			
      DUP2 			
      ADD 			
      SWAP1 			
      POP 			
      PUSH [tag] 119			
      JUMP 			
    tag 121			
      JUMPDEST 			
      PUSH 0			
      DUP5 			
      DUP5 			
      ADD 			
      MSTORE 			
      POP 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 55			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 123			
      DUP3 			
      PUSH [tag] 52			
      JUMP 			
    tag 123			
      JUMPDEST 			
      PUSH [tag] 124			
      DUP2 			
      DUP6 			
      PUSH [tag] 53			
      JUMP 			
    tag 124			
      JUMPDEST 			
      SWAP4 			
      POP 			
      PUSH [tag] 125			
      DUP2 			
      DUP6 			
      PUSH 20			
      DUP7 			
      ADD 			
      PUSH [tag] 54			
      JUMP 			
    tag 125			
      JUMPDEST 			
      PUSH [tag] 126			
      DUP2 			
      PUSH [tag] 44			
      JUMP 			
    tag 126			
      JUMPDEST 			
      DUP5 			
      ADD 			
      SWAP2 			
      POP 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 15			
      JUMPDEST 			
      PUSH 0			
      PUSH 20			
      DUP3 			
      ADD 			
      SWAP1 			
      POP 			
      DUP2 			
      DUP2 			
      SUB 			
      PUSH 0			
      DUP4 			
      ADD 			
      MSTORE 			
      PUSH [tag] 128			
      DUP2 			
      DUP5 			
      PUSH [tag] 55			
      JUMP 			
    tag 128			
      JUMPDEST 			
      SWAP1 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 56			
      JUMPDEST 			
      PUSH [tag] 130			
      DUP2 			
      PUSH [tag] 37			
      JUMP 			
    tag 130			
      JUMPDEST 			
      DUP2 			
      EQ 			
      PUSH [tag] 131			
      JUMPI 			
      PUSH 0			
      DUP1 			
      REVERT 			
    tag 131			
      JUMPDEST 			
      POP 			
      JUMP 			
    tag 57			
      JUMPDEST 			
      PUSH 0			
      DUP2 			
      CALLDATALOAD 			
      SWAP1 			
      POP 			
      PUSH [tag] 133			
      DUP2 			
      PUSH [tag] 56			
      JUMP 			
    tag 133			
      JUMPDEST 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 18			
      JUMPDEST 			
      PUSH 0			
      PUSH 20			
      DUP3 			
      DUP5 			
      SUB 			
      SLT 			
      ISZERO 			
      PUSH [tag] 135			
      JUMPI 			
      PUSH [tag] 136			
      PUSH [tag] 40			
      JUMP 			
    tag 136			
      JUMPDEST 			
    tag 135			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 137			
      DUP5 			
      DUP3 			
      DUP6 			
      ADD 			
      PUSH [tag] 57			
      JUMP 			
    tag 137			
      JUMPDEST 			
      SWAP2 			
      POP 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 58			
      JUMPDEST 			
      PUSH 4E487B7100000000000000000000000000000000000000000000000000000000			
      PUSH 0			
      MSTORE 			
      PUSH 11			
      PUSH 4			
      MSTORE 			
      PUSH 24			
      PUSH 0			
      REVERT 			
    tag 23			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 140			
      DUP3 			
      PUSH [tag] 37			
      JUMP 			
    tag 140			
      JUMPDEST 			
      SWAP2 			
      POP 			
      PUSH [tag] 141			
      DUP4 			
      PUSH [tag] 37			
      JUMP 			
    tag 141			
      JUMPDEST 			
      SWAP3 			
      POP 			
      DUP3 			
      DUP3 			
      ADD 			
      SWAP1 			
      POP 			
      DUP1 			
      DUP3 			
      GT 			
      ISZERO 			
      PUSH [tag] 142			
      JUMPI 			
      PUSH [tag] 143			
      PUSH [tag] 58			
      JUMP 			
    tag 143			
      JUMPDEST 			
    tag 142			
      JUMPDEST 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 59			
      JUMPDEST 			
      PUSH 4E487B7100000000000000000000000000000000000000000000000000000000			
      PUSH 0			
      MSTORE 			
      PUSH 22			
      PUSH 4			
      MSTORE 			
      PUSH 24			
      PUSH 0			
      REVERT 			
    tag 27			
      JUMPDEST 			
      PUSH 0			
      PUSH 2			
      DUP3 			
      DIV 			
      SWAP1 			
      POP 			
      PUSH 1			
      DUP3 			
      AND 			
      DUP1 			
      PUSH [tag] 146			
      JUMPI 			
      PUSH 7F			
      DUP3 			
      AND 			
      SWAP2 			
      POP 			
    tag 146			
      JUMPDEST 			
      PUSH 20			
      DUP3 			
      LT 			
      DUP2 			
      SUB 			
      PUSH [tag] 147			
      JUMPI 			
      PUSH [tag] 148			
      PUSH [tag] 59			
      JUMP 			
    tag 148			
      JUMPDEST 			
    tag 147			
      JUMPDEST 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 60			
      JUMPDEST 			
      PUSH 0			
      DUP2 			
      SWAP1 			
      POP 			
      DUP2 			
      PUSH 0			
      MSTORE 			
      PUSH 20			
      PUSH 0			
      KECCAK256 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 61			
      JUMPDEST 			
      PUSH 0			
      PUSH 20			
      PUSH 1F			
      DUP4 			
      ADD 			
      DIV 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 62			
      JUMPDEST 			
      PUSH 0			
      DUP3 			
      DUP3 			
      SHL 			
      SWAP1 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 63			
      JUMPDEST 			
      PUSH 0			
      PUSH 8			
      DUP4 			
      MUL 			
      PUSH [tag] 153			
      PUSH FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF			
      DUP3 			
      PUSH [tag] 62			
      JUMP 			
    tag 153			
      JUMPDEST 			
      PUSH [tag] 154			
      DUP7 			
      DUP4 			
      PUSH [tag] 62			
      JUMP 			
    tag 154			
      JUMPDEST 			
      SWAP6 			
      POP 			
      DUP1 			
      NOT 			
      DUP5 			
      AND 			
      SWAP4 			
      POP 			
      DUP1 			
      DUP7 			
      AND 			
      DUP5 			
      OR 			
      SWAP3 			
      POP 			
      POP 			
      POP 			
      SWAP4 			
      SWAP3 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 64			
      JUMPDEST 			
      PUSH 0			
      DUP2 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 65			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 157			
      PUSH [tag] 158			
      PUSH [tag] 159			
      DUP5 			
      PUSH [tag] 37			
      JUMP 			
    tag 159			
      JUMPDEST 			
      PUSH [tag] 64			
      JUMP 			
    tag 158			
      JUMPDEST 			
      PUSH [tag] 37			
      JUMP 			
    tag 157			
      JUMPDEST 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 66			
      JUMPDEST 			
      PUSH 0			
      DUP2 			
      SWAP1 			
      POP 			
      SWAP2 			
      SWAP1 			
      POP 			
      JUMP 			
    tag 67			
      JUMPDEST 			
      PUSH [tag] 162			
      DUP4 			
      PUSH [tag] 65			
      JUMP 			
    tag 162			
      JUMPDEST 			
      PUSH [tag] 163			
      PUSH [tag] 164			
      DUP3 			
      PUSH [tag] 66			
      JUMP 			
    tag 164			
      JUMPDEST 			
      DUP5 			
      DUP5 			
      SLOAD 			
      PUSH [tag] 63			
      JUMP 			
    tag 163			
      JUMPDEST 			
      DUP3 			
      SSTORE 			
      POP 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 68			
      JUMPDEST 			
      PUSH 0			
      SWAP1 			
      JUMP 			
    tag 69			
      JUMPDEST 			
      PUSH [tag] 167			
      PUSH [tag] 68			
      JUMP 			
    tag 167			
      JUMPDEST 			
      PUSH [tag] 168			
      DUP2 			
      DUP5 			
      DUP5 			
      PUSH [tag] 67			
      JUMP 			
    tag 168			
      JUMPDEST 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 70			
      JUMPDEST 			
    tag 170			
      JUMPDEST 			
      DUP2 			
      DUP2 			
      LT 			
      ISZERO 			
      PUSH [tag] 172			
      JUMPI 			
      PUSH [tag] 173			
      PUSH 0			
      DUP3 			
      PUSH [tag] 69			
      JUMP 			
    tag 173			
      JUMPDEST 			
      PUSH 1			
      DUP2 			
      ADD 			
      SWAP1 			
      POP 			
      PUSH [tag] 170			
      JUMP 			
    tag 172			
      JUMPDEST 			
      POP 			
      POP 			
      JUMP 			
    tag 71			
      JUMPDEST 			
      PUSH 1F			
      DUP3 			
      GT 			
      ISZERO 			
      PUSH [tag] 175			
      JUMPI 			
      PUSH [tag] 176			
      DUP2 			
      PUSH [tag] 60			
      JUMP 			
    tag 176			
      JUMPDEST 			
      PUSH [tag] 177			
      DUP5 			
      PUSH [tag] 61			
      JUMP 			
    tag 177			
      JUMPDEST 			
      DUP2 			
      ADD 			
      PUSH 20			
      DUP6 			
      LT 			
      ISZERO 			
      PUSH [tag] 178			
      JUMPI 			
      DUP2 			
      SWAP1 			
      POP 			
    tag 178			
      JUMPDEST 			
      PUSH [tag] 179			
      PUSH [tag] 180			
      DUP6 			
      PUSH [tag] 61			
      JUMP 			
    tag 180			
      JUMPDEST 			
      DUP4 			
      ADD 			
      DUP3 			
      PUSH [tag] 70			
      JUMP 			
    tag 179			
      JUMPDEST 			
      POP 			
      POP 			
    tag 175			
      JUMPDEST 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    tag 72			
      JUMPDEST 			
      PUSH 0			
      DUP3 			
      DUP3 			
      SHR 			
      SWAP1 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 73			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 183			
      PUSH 0			
      NOT 			
      DUP5 			
      PUSH 8			
      MUL 			
      PUSH [tag] 72			
      JUMP 			
    tag 183			
      JUMPDEST 			
      NOT 			
      DUP1 			
      DUP4 			
      AND 			
      SWAP2 			
      POP 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 74			
      JUMPDEST 			
      PUSH 0			
      PUSH [tag] 185			
      DUP4 			
      DUP4 			
      PUSH [tag] 73			
      JUMP 			
    tag 185			
      JUMPDEST 			
      SWAP2 			
      POP 			
      DUP3 			
      PUSH 2			
      MUL 			
      DUP3 			
      OR 			
      SWAP1 			
      POP 			
      SWAP3 			
      SWAP2 			
      POP 			
      POP 			
      JUMP 			
    tag 25			
      JUMPDEST 			
      PUSH [tag] 187			
      DUP3 			
      PUSH [tag] 52			
      JUMP 			
    tag 187			
      JUMPDEST 			
      PUSH FFFFFFFFFFFFFFFF			
      DUP2 			
      GT 			
      ISZERO 			
      PUSH [tag] 188			
      JUMPI 			
      PUSH [tag] 189			
      PUSH [tag] 45			
      JUMP 			
    tag 189			
      JUMPDEST 			
    tag 188			
      JUMPDEST 			
      PUSH [tag] 190			
      DUP3 			
      SLOAD 			
      PUSH [tag] 27			
      JUMP 			
    tag 190			
      JUMPDEST 			
      PUSH [tag] 191			
      DUP3 			
      DUP3 			
      DUP6 			
      PUSH [tag] 71			
      JUMP 			
    tag 191			
      JUMPDEST 			
      PUSH 0			
      PUSH 20			
      SWAP1 			
      POP 			
      PUSH 1F			
      DUP4 			
      GT 			
      PUSH 1			
      DUP2 			
      EQ 			
      PUSH [tag] 193			
      JUMPI 			
      PUSH 0			
      DUP5 			
      ISZERO 			
      PUSH [tag] 194			
      JUMPI 			
      DUP3 			
      DUP8 			
      ADD 			
      MLOAD 			
      SWAP1 			
      POP 			
    tag 194			
      JUMPDEST 			
      PUSH [tag] 195			
      DUP6 			
      DUP3 			
      PUSH [tag] 74			
      JUMP 			
    tag 195			
      JUMPDEST 			
      DUP7 			
      SSTORE 			
      POP 			
      PUSH [tag] 192			
      JUMP 			
    tag 193			
      JUMPDEST 			
      PUSH 1F			
      NOT 			
      DUP5 			
      AND 			
      PUSH [tag] 196			
      DUP7 			
      PUSH [tag] 60			
      JUMP 			
    tag 196			
      JUMPDEST 			
      PUSH 0			
    tag 197			
      JUMPDEST 			
      DUP3 			
      DUP2 			
      LT 			
      ISZERO 			
      PUSH [tag] 199			
      JUMPI 			
      DUP5 			
      DUP10 			
      ADD 			
      MLOAD 			
      DUP3 			
      SSTORE 			
      PUSH 1			
      DUP3 			
      ADD 			
      SWAP2 			
      POP 			
      PUSH 20			
      DUP6 			
      ADD 			
      SWAP5 			
      POP 			
      PUSH 20			
      DUP2 			
      ADD 			
      SWAP1 			
      POP 			
      PUSH [tag] 197			
      JUMP 			
    tag 199			
      JUMPDEST 			
      DUP7 			
      DUP4 			
      LT 			
      ISZERO 			
      PUSH [tag] 200			
      JUMPI 			
      DUP5 			
      DUP10 			
      ADD 			
      MLOAD 			
      PUSH [tag] 201			
      PUSH 1F			
      DUP10 			
      AND 			
      DUP3 			
      PUSH [tag] 73			
      JUMP 			
    tag 201			
      JUMPDEST 			
      DUP4 			
      SSTORE 			
      POP 			
    tag 200			
      JUMPDEST 			
      PUSH 1			
      PUSH 2			
      DUP9 			
      MUL 			
      ADD 			
      DUP9 			
      SSTORE 			
      POP 			
      POP 			
      POP 			
    tag 192			
      JUMPDEST 			
      POP 			
      POP 			
      POP 			
      POP 			
      POP 			
      POP 			
      JUMP 			
    .data