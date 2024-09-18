import re
from z3 import *

from baseBlock import BasicBlock
from graph import Graph
import utils as util
from generator import *
import preCheck as preCheck

# SAT/UNSAT/Unknown Results from Z3 Solver
SAT_RESULT = CheckSatResult(Z3_L_TRUE)
UNSAT_RESULT = CheckSatResult(Z3_L_FALSE)
UNKNOWN_RESULT = CheckSatResult(Z3_L_UNDEF)

# Solver configuration constants
MAX_DEPTH = 300
UNSIGNED_BOUND_NUMBER = 2**256 - 1
CONSTANT_ONES_159 = BitVecVal((1 << 160) - 1, 256)
MEM_SIZE = 2000
LOOP_LIMIT = 10

# File paths and postfixes for contract creation and runtime
CREATION_PATH = "./opcodes-creation/"
CREATION_POSTFIX = ".opcodes-creation"
SOLFILE_PATH = "./output/"
RUNTIME_PATH = "./opcodes-runtime/"
RUNTIME_POSTFIX = ".opcodes-runtime"

# Z3 solver instance with global access
solver = Solver()
set_option(timeout=2500)

# Variable generator instance
variable_generator = VariableGenerator()

# Global state for symbolic execution
global_state = {
    'caller_address': BitVec("caller_address", 256),
    'data_load': BitVec("data_load", 256),
    'data_size': BitVec("data_size", 256),
    'call_data_address': BitVec("call_data_address", 256),
    'gas': BitVec("gas", 256),
    'selfbalance': BitVec("selfbalance", 256),
    'coinbase': BitVec("coinbase", 256),
    'difficulty': BitVec("difficulty", 256),
    'gaslimit': BitVec("gaslimit", 256),
    'timestamp': BitVec("timestamp", 256),
    'number': BitVec("number", 256),
    'gasprice': BitVec("gasprice", 256),
    'blockhash': BitVec("blockhash", 256),
    'origin': BitVec("origin", 256),
    'chainid': BitVec("chainid", 256),
    'codehash': BitVec("codehash", 256),
    'msize': 0
}

class SmartContractAnalyzer:
    
    def __init__(self, name, index, sig):
        """
        Initialize the SmartContractAnalyzer.
        This method sets up storage, operational dictionaries, basic blocks, 
        and edges for contract creation and runtime paths.
        """
        self.name = name
        self.index = index
        self.sig = sig

        # Storage-related 
        self.storage = {}
        self.op_dict_c = {}
        self.op_dict_r = {}
        self.value_dict_c = {}
        self.value_dict_r = {}

        # Control flow and blocks
        self.blocks_c = []
        self.blocks_r = []
        self.edges_c = []
        self.edges_r = []
        self.visited = []
        self.stack = []
        self.graph_dict = {}
        self.graph_dict_reverse = {}
        self.visitedEdges = {}

        # Memory and symbolic execution
        self.store_real = {}
        self.store_symbolic = {}
        self.store_map = {}
        self.mem_real = []
        self.mem_symbolic = {}
        self.balance_map = {}
        self.path_condition = []
        self.money_flow = []
        self.money_flow_path = []
        self.call_data_map = {}

        # Ownership and vulnerability flags
        self.owner_key = -1
        self.owner_value = ""
        self.initialize_flags()

        # Other analysis parameters
        self.depth = 0

        # Initialize and process the contract
        self.process()
        self.check()

    def initialize_flags(self):
        """
        Initialize vulnerability flags related to symbolic execution.
        """
        self.UEC = False  # Unchecked external call
        self.ORI = False  # Origin access issue
        self.SLF = False  # Selfdestruct flag
        self.BID = False  # Block info depandcy
        self.DOS = False  # Denial of service
        self.RAD = False  # Bad randoms 
        self.TOD = False  # Transction order
        self.REC = False  # Reentrancy condition
        self.SAA = False  # Signature abuse attack
        self.overflow = False  # Overflow vulnerability
        self.integer_over = False  # Integer overflow
        self.integer_under = False  # Integer underflow

    def clear_block_message(self):
        """
        Clear block-related messages and reset the solver for the next analysis.
        """
        self.visited.clear()
        self.stack.clear()
        self.depth = 0
        self.graph_dict.clear()
        self.graph_dict_reverse.clear()
        self.store_real.clear()
        self.store_symbolic.clear()
        self.balance_map.clear()
        self.path_condition.clear()
        self.call_data_map.clear()
        self.mem_real.clear()
        self.mem_symbolic.clear()
        self.money_flow.clear()
        self.money_flow_path.clear()
        self.store_map.clear()
        solver.reset()

    def process(self):
        """
        Process contract creation and runtime paths.
        Constructs the control flow graph (CFG) and performs symbolic execution.
        """
        # Construct CFG for contract creation
        creation_path = CREATION_PATH + self.name + CREATION_POSTFIX
        self.construct_cfg(creation_path, self.op_dict_c, self.value_dict_c, self.blocks_c, self.edges_c)
        self.symbolic_exec_block(0, True, self.stack, self.op_dict_c, self.value_dict_c, self.edges_c, self.money_flow, 0)

        # Clear messages and reset for runtime analysis
        self.clear_block_message()

        # Construct CFG for contract runtime
        runtime_path = RUNTIME_PATH + self.name + RUNTIME_POSTFIX
        self.construct_cfg(runtime_path, self.op_dict_r, self.value_dict_r, self.blocks_r, self.edges_r)
        self.symbolic_exec_block(0, False, self.stack, self.op_dict_r, self.value_dict_r, self.edges_r, self.money_flow, 0)

    def construct_cfg(self, file_path, op_dict, value_dict, blocks, edges):
        """
        Constructs the control flow graph (CFG) by parsing the opcode file.
        """
        with open(file_path, 'r') as disasm_file:
            self.parse_opcodes(disasm_file, op_dict, value_dict, blocks, edges)
    
    def extract_program_counter(self, str_pc):
        """
        Extract the program counter (PC) from the disassembled line.
        """
        try:
            return int(str_pc.replace(":", "", 1), 16)
        except ValueError:
            self.write_msg(f"opcodes error>> {self.name}")
            return None
        
    def sanitize_opcode(self, opcode):
        """
        Sanitize opcode names to ensure consistency.
        """
        if opcode == "Missing":
            return "INVALID"
        if opcode == "KECCAK256":
            return "SHA3"
        if opcode == "opcode":
            return "INVALID"
        return opcode
    
    def create_block_elements(self, opcode, pc, op_list):
        """
        Create elements for a block and mark block boundaries for CFG.
        """
        if opcode in ["STOP", "JUMP", "JUMPI", "RETURN", "SUICIDE", "REVERT", "ASSERTFAIL"]:
            op_list.append({'pc': pc, 'opcode': opcode, 'depart': False})
            op_list.append({'depart': True})
        elif opcode == "JUMPDEST":
            if not op_list[-1]['depart']:
                op_list.append({'depart': True})
            op_list.append({'pc': pc, 'opcode': opcode, 'depart': False})
        else:
            op_list.append({'pc': pc, 'opcode': opcode, 'depart': False})

    def parse_opcodes(self, disasm_file, op_dict, value_dict, blocks, edges):
        """
        Parse the opcodes and create basic blocks and edges for the CFG.
        """
        op_list = []
        move_first_line = False

        # Parse the file line by line
        for line in disasm_file:
            if not move_first_line:
                move_first_line = True
                continue

            if not line.strip():
                break

            str_list = line.split(' ')
            pc = self.extract_program_counter(str_list[0])
            opcode = self.sanitize_opcode(str_list[1].strip())

            # Map PC to opcode and value if applicable
            op_dict[pc] = opcode
            if len(str_list) > 2 and opcode != "INVALID":
                value_dict[pc] = str_list[-1].strip()

            # Create block elements based on opcode types
            self.create_block_elements(opcode, pc, op_list)

        # Finalize the list of blocks and edges
        self.finalize_cfg_blocks(op_list, op_dict, blocks, edges)

    def finalize_cfg_blocks(self, op_list, op_dict, blocks, edges):
        """
        Finalize the construction of basic blocks and edges for the CFG.
        """
        if not op_list:
            return

        if not op_list[-1]['depart']:
            op_list.append({'depart': True})

        start_line = 0
        new_block = True

        for i, op_ele in enumerate(op_list):
            if new_block:
                block = BasicBlock(start_line)
                new_block = False

            if not op_ele['depart']:
                block.add_instruction(op_ele['pc'])
                continue

            block.set_end_address(op_list[i-1]['pc'])
            blocks.append(block)
            new_block = True
            if i + 1 < len(op_list):
                start_line = op_list[i+1]['pc']

        self.assign_block_types(blocks, op_dict)
        self.create_edges(blocks, op_dict, edges)
    
    def assign_block_types(self, blocks, op_dict):
        """
        Assign block types based on the terminating opcode.
        """
        for block in blocks:
            end_address = block.get_end_address()
            block_type = self.determine_block_type(op_dict[end_address])
            block.set_block_type(block_type)

    def determine_block_type(self, opcode):
        """
        Determine the block type based on the opcode.
        """
        if opcode == "JUMPI":
            return "conditional"
        if opcode == "JUMP":
            return "unconditional"
        if opcode in ["STOP", "RETURN", "SUICIDE", "REVERT", "ASSERTFAIL"]:
            return "terminal"
        return "fall_to"
    
    def create_edges(self, blocks, op_dict, edges):
        """
        Create control flow edges between blocks.
        """
        for block in blocks:
            if block.get_block_type() not in ["unconditional", "terminal"]:
                self.link_fallthrough_blocks(block, blocks, op_dict, edges)

    def link_fallthrough_blocks(self, block, blocks, op_dict, edges):
        """
        Link blocks that have a fall-through control flow.
        """
        interval = self.get_opcode_interval(op_dict, block)
        for fall_block in blocks:
            if fall_block.get_start_address() == block.get_end_address() + interval:
                block.set_fall_to(fall_block.get_start_address())
                edges.append({block.get_start_address(): fall_block.get_start_address()})

    def get_opcode_interval(self, op_dict, block):
        """
        Calculate the interval between program counters, based on PUSH opcodes.
        """
        end_address = block.get_end_address()
        if op_dict[end_address].startswith("PUSH"):
            vstr = re.search(r"\d+", op_dict[end_address]).group(0)
            return 1 + int(vstr)
        return 1

    def symbolic_exec_block(self,tag,ctag,stack,op_dict,value_dict,edges,money_flow,preblock):
        
        """
        symbolic execution block
        """
        global solver
        
        self.depth = self.depth + 1
        if (self.depth > MAX_DEPTH):
            msg = "depth max " + self.name
            self.write_msg(msg)
            if not self.overflow:
                self.overflow = True
            return
        
        block = self.get_block(tag,ctag)
        if not block:
            return
        
        accessList = sorted([preblock,tag])
        accessKey = str(accessList[0]) + "_" + str(accessList[1])
        if accessKey not in self.visitedEdges:
            self.visitedEdges[accessKey] = 0
        else: 
            self.visitedEdges[accessKey] = self.visitedEdges[accessKey] + 1

        if self.visitedEdges[accessKey] > LOOP_LIMIT:
            return

        for i,ins in enumerate(block.get_instructions()):
            self.symbolic_exec_ins(block,ins,stack,op_dict,value_dict,edges,ctag,money_flow)

        if money_flow not in self.money_flow_path:
            self.money_flow_path.append(money_flow)
        
        if block.get_block_type() == "terminal" or self.depth > MAX_DEPTH:
            return
        elif block.get_block_type() == "unconditional":
            successor = block.get_jump_target()
            self.symbolic_exec_block(successor,ctag,stack,op_dict,value_dict,edges,money_flow,tag)
        elif block.get_block_type() == "fall_to":
                successor = block.get_fall_to()
                self.symbolic_exec_block(successor,ctag,stack,op_dict,value_dict,edges,money_flow,tag)
        elif block.get_block_type() == "conditional":

            branch_expression = block.get_branch_expression()
            solver.push() 
            solver.add(branch_expression)

            try:
                if solver.check() == UNSAT_RESULT:
                    self.write_msg("INFEASIBLE PATH DETECTED")
                elif solver.check() == SAT_RESULT:
                    self.path_condition.append(branch_expression)
                    left_branch = block.get_jump_target()
                    lblock = self.get_block(left_branch,ctag)
                    lblock.set_path_condition(block.get_path_condition())
                    lblock.add_path_condition(branch_expression)
                    self.symbolic_exec_block(left_branch,ctag,stack,op_dict,value_dict,edges,money_flow,tag)
                else:
                    if solver.reason_unknown() == "canceled":
                        self.write_msg("z3 time out")
                        self.path_condition.append(branch_expression)
                        left_branch = block.get_jump_target()
                        lblock = self.get_block(left_branch,ctag)
                        lblock.set_path_condition(block.get_path_condition())
                        lblock.add_path_condition(branch_expression)
                        self.symbolic_exec_block(left_branch,ctag,stack,op_dict,value_dict,edges,money_flow,tag)
            except TimeoutError:
                    raise
            except Exception as e:
                    self.write_msg("z3 error" + e.__str__())
                
            solver.pop()    
            solver.push()  
            negated_branch_expression = Not(branch_expression)
            solver.add(negated_branch_expression)
      
            try:
                if solver.check() == UNSAT_RESULT:
                    self.write_msg("INFEASIBLE PATH DETECTED")
                elif solver.check() == SAT_RESULT:
                    right_branch = block.get_fall_to()
                    rblock = self.get_block(right_branch,ctag)
                    rblock.set_path_condition(block.get_path_condition())
                    rblock.add_path_condition(negated_branch_expression)
                    self.path_condition.append(negated_branch_expression)
                    self.symbolic_exec_block(right_branch,ctag,stack,op_dict,value_dict,edges,money_flow,tag)
                else:
                    if solver.reason_unknown() == "canceled":
                        self.write_msg("z3 time out")
                        right_branch = block.get_fall_to()
                        rblock = self.get_block(right_branch,ctag)
                        rblock.set_path_condition(block.get_path_condition())
                        rblock.add_path_condition(negated_branch_expression)
                        self.path_condition.append(negated_branch_expression)
                        self.symbolic_exec_block(right_branch,ctag,stack,op_dict,value_dict,edges,money_flow,tag)
            except TimeoutError:
                raise
            except Exception as e:
                    self.write_msg("z3 error" + e.__str__())
            
            solver.pop()

    def symbolic_exec_ins(self,block,ins,stack,op_dict,value_dict,edges,ctag,money_flow):
        
        """
        symbolic execution ins
        """

        op_code = op_dict[ins]
        if op_code.startswith("PUSH"):
            if value_dict.__contains__(ins):
                if self.is_valid_function_signature(value_dict[ins]):
                    if value_dict[ins] in self.sig:
                        pushed_value = int(value_dict[ins], 16)
                    else:
                        new_var_name = variable_generator.generate_function_signature()
                        pushed_value = BitVec(new_var_name, 256)
                else:
                    pushed_value = int(value_dict[ins], 16)
                stack.insert(0,pushed_value)
            else:
                raise ValueError('VALUE missing')
        elif op_code == "CALLDATASIZE":
            stack.insert(0,global_state['data_size'])
        elif op_code == "CALLDATALOAD":
            if len(stack) > 0:
                position = stack.pop(0)
                call_data_name = "data_load_" + str(position)
                if call_data_name not in self.call_data_map:
                    var = BitVec(call_data_name, 256)
                    self.call_data_map[call_data_name] = var
                stack.insert(0, self.call_data_map[call_data_name] )
                
            else:
                raise ValueError('STACK underflow')
        elif op_code == "POP":
            if len(stack) > 0:
                stack.pop(0)
                
            else:
                raise ValueError('STACK underflow')
        elif op_code == "CALLER":
            stack.insert(0,global_state['caller_address'])
            
        elif op_code == "CHAINID":
            stack.insert(0,global_state['chainid'])
            
        elif op_code == "MSIZE":
            msize = 32 * global_state['msize']
            stack.insert(0,msize)
            
        elif op_code == "SIGNEXTEND":
            if len(stack) > 1:
                if util.are_all_real(first, second):
                    if first >= 32 or first < 0:
                        computed = second
                    else:
                        signbit_index_from_right = 8 * first + 7
                        if second & (1 << signbit_index_from_right):
                            computed = second | (2 ** 256 - (1 << signbit_index_from_right))
                        else:
                            computed = second & ((1 << signbit_index_from_right) - 1 )
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)
                    solver.push()
                    solver.add( Not( Or(first >= 32, first < 0 ) ) )
                    if util.check_satisfiability(solver) == UNSAT_RESULT:
                        computed = second
                    else:
                        signbit_index_from_right = 8 * first + 7
                        solver.push()
                        solver.add(second & (1 << signbit_index_from_right) == 0)
                        if util.check_satisfiability(solver) == UNSAT_RESULT:
                            computed = second | (2 ** 256 - (1 << signbit_index_from_right))
                        else:
                            computed = second & ((1 << signbit_index_from_right) - 1)
                        solver.pop()
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
            else:
                raise ValueError('STACK underflow')   
        elif op_code == "MULMOD":
            if len(stack) > 2:
                first = stack.pop(0)
                second = stack.pop(0)
                third = stack.pop(0)

                if util.are_all_real(first, second, third):
                    if third == 0:
                        computed = 0
                    else:
                        computed = (first * second) % third
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)
                    solver.push()
                    solver.add( Not(third == 0) )
                    if util.check_satisfiability(solver) == UNSAT_RESULT:
                        computed = 0
                    else:
                        first = ZeroExt(256, first)
                        second = ZeroExt(256, second)
                        third = ZeroExt(256, third)
                        computed = URem(first * second, third)
                        computed = Extract(255, 0, computed)
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
            else:
                raise ValueError('STACK underflow')
        elif op_code == "EXTCODEHASH":
            if len(stack) > 1:
                address = stack.pop(0)
                stack.insert(0, global_state['codehash'])
            else:
                raise ValueError('STACK underflow')
            ins = ins + 1
        elif op_code == "EQ":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)

                if is_expr(first):
                    if ins == 140:
                        print()
                    self.check_EQ(first)
                if is_expr(second):
                    self.check_EQ(second) 

                if util.are_all_real(first, second):
                    if first == second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    computed = If(first == second, BitVecVal(1, 256), BitVecVal(0, 256))
                    if util.is_real(first) and first == 0:
                        block.add_eq_expression(second)
                    if util.is_real(second) and second == 0:
                        block.add_eq_expression(first)
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
            else:
                raise ValueError('STACK underflow')
        elif op_code.startswith("DUP"):
            vstr = re.search(r"\d+", op_code).group(0)
            num = int(vstr)
            if len(stack) >= num:
                duplicate = stack[num - 1]
                stack.insert(0, duplicate)
                
            else:
                raise ValueError('STACK underflow')
        elif op_code.startswith("LOG"):
            vstr = re.search(r"\d+", op_code).group(0)
            num = int(vstr) + 2
            if len(stack) >= num:
                while num > 0:
                    stack.pop(0)
                    num = num - 1
            else:
                raise ValueError('STACK underflow')
            
        elif op_code == "SELFBALANCE":
            stack.insert(0,global_state['selfbalance'])
            ins = ins + 1
        elif op_code == "SUB":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.is_real(first) and util.is_symbolic(second):
                    first = BitVecVal(first, 256)
                    computed = first - second
                elif util.is_symbolic(first) and util.is_real(second):
                    second = BitVecVal(second, 256)
                    computed = first - second
                else:
                    computed = first - second
                computed = simplify(computed) if is_expr(computed) else computed
                check_revert = False
                if block.get_block_type() == 'conditional':
                    if hasattr(block,'jump_target'): 
                        jump_target = block.get_jump_target()
                        jblock = self.get_block(jump_target,ctag)
                        if jblock:
                            check_revert = any([True for instruction in jblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                    if not check_revert and hasattr(block,'fall_to'): 
                        fall_to = block.get_fall_to()
                        fblock = self.get_block(fall_to,ctag)
                        if fblock:
                            check_revert = any([True for instruction in fblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                if block.get_block_type() != 'conditional' or not check_revert:
                    self.check_inter_underflow(first,second,block)
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "ADD":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.is_real(first) and util.is_symbolic(second):
                    first = BitVecVal(first, 256)
                    computed = first + second
                elif util.is_symbolic(first) and util.is_real(second):
                    second = BitVecVal(second, 256)
                    computed = first + second
                else:
                    computed = first + second
                computed = simplify(computed) if is_expr(computed) else computed
                check_revert = False
                if block.get_block_type() == 'conditional':
                    if hasattr(block,'jump_target'): 
                        jump_target = block.get_jump_target()
                        jblock = self.get_block(jump_target,ctag)
                        if  jblock:
                            check_revert = any([True for instruction in jblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                    if not check_revert and hasattr(block,'fall_to'): 
                        fall_to = block.get_fall_to()
                        fblock = self.get_block(fall_to,ctag)
                        if fblock:
                            check_revert = any([True for instruction in fblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                if block.get_block_type() != 'conditional' or not check_revert:
                    self.check_inter_overflow(first,computed,second,block)

                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "EXP":
            if len(stack) > 1:
                base = stack.pop(0)
                exponent = stack.pop(0)
                if util.are_all_real(base, exponent):
                    computed = pow(base, exponent, 2**256)
                else:
                    new_var_name = variable_generator.generate_arbitrary_variable()
                    computed = BitVec(new_var_name, 256)
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code.startswith("SWAP"):
            vstr = re.search(r"\d+", op_code).group(0)
            num = int(vstr)
            if len(stack) > num:
                temp = stack[num]
                stack[num] = stack[0]
                stack[0] = temp
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SHR":
            if len(stack) > 1:
                shift = stack.pop(0)
                value = stack.pop(0)
                if util.is_real(shift) and util.is_symbolic(value):
                    shift = BitVecVal(shift, 256)
                    computed = LShR(value,shift)
                elif util.is_symbolic(shift) and util.is_real(value):
                    value = BitVecVal(value, 256)
                    computed = LShR(value,shift)
                elif util.are_all_real(shift,value):
                    value = BitVecVal(value, 256)
                    shift = BitVecVal(shift, 256)
                    computed = LShR(value,shift)
                else:
                    computed = LShR(value,shift)
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0,computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SHL":
            if len(stack) > 1:
                shift = stack.pop(0)
                value = stack.pop(0)
                if util.is_real(shift) and util.is_symbolic(value):
                    shift = BitVecVal(shift, 256)
                    computed = value << shift
                elif util.is_symbolic(shift) and util.is_real(value):
                    value = BitVecVal(value, 256)
                    computed = value << shift
                else:
                    computed = value << shift
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0,computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "REVERT":
            if len(stack) > 1:
                stack.pop(0)
                stack.pop(0)
            ins = ins + 1
        elif op_code == "JUMP":
            if len(stack) > 0:
                target_address = stack.pop(0)
                if util.is_symbolic(target_address):
                    try:
                        target_address = int(str(simplify(target_address)))
                    except:
                        raise TypeError("Target address attriubute error")
                block.set_jump_target(target_address)
                if not self.has_edges(edges,block.get_start_address(),target_address):
                    self.add_edges(edges,block.get_start_address(),target_address)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "RETURN":
            if len(stack) > 1:
                stack.pop(0)
                stack.pop(0)
            ins = ins + 1
        elif op_code == "CREATE2":
            if len(stack) > 3:
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
                new_var_name = variable_generator.generate_arbitrary_variable()
                new_var = BitVec(new_var_name, 256)
                stack.insert(0, new_var)
            else:
                raise ValueError('STACK underflow')
        elif op_code == "LT":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    first = util.to_unsigned(first)
                    second = util.to_unsigned(second)
                    if first < second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    self._check_and_set_BID(first)
                    self._check_and_set_BID(second)
                    computed = If(ULT(first, second), BitVecVal(1, 256), BitVecVal(0, 256))
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "GT":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    first = util.to_unsigned(first)
                    second = util.to_unsigned(second)
                    if first > second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    self._check_and_set_BID(first)
                    self._check_and_set_BID(second)
                    computed = If(UGT(first, second), BitVecVal(1, 256), BitVecVal(0, 256))
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SGT":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    first = util.to_signed(first)
                    second = util.to_signed(second)
                    if first > second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    self._check_and_set_BID(second)
                    self._check_and_set_BID(first)
                    computed = If(first > second, BitVecVal(1, 256), BitVecVal(0, 256))
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "ISZERO":
            if len(stack) > 0:
                first = stack.pop(0)
                if util.is_real(first): 
                    if first == 0:
                        computed = 1
                    else:
                        computed = 0
                else:
                    computed = If(first == 0, BitVecVal(1, 256), BitVecVal(0, 256))
                    block.add_is_zero_expression(computed)
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SLT":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    first = util.to_signed(first)
                    second = util.to_signed(second)
                    if first < second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    self._check_and_set_BID(first)
                    self._check_and_set_BID(second)
                    computed = If(first < second, BitVecVal(1, 256), BitVecVal(0, 256))
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "MUL":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.is_real(first) and util.is_symbolic(second):
                    first = BitVecVal(first, 256)
                elif util.is_symbolic(first) and util.is_real(second):
                    second = BitVecVal(second, 256)
                computed = first * second & UNSIGNED_BOUND_NUMBER
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "DIV":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    if second == 0:
                        computed = 0
                    else:
                        first = util.to_unsigned(first)
                        second = util.to_unsigned(second)
                        computed = first / second
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)
                    solver.push()
                    solver.add( Not (second == 0) )
                    if util.check_satisfiability(solver) == UNSAT_RESULT:
                        computed = 0
                    else:
                        computed = UDiv(first, second)
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SDIV":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    first = util.to_signed(first)
                    second = util.to_signed(second)
                    if second == 0:
                        computed = 0
                    elif first == -2**255 and second == -1:
                        computed = -2**255
                    else:
                        sign = -1 if (first / second) < 0 else 1
                        computed = sign * ( abs(first) / abs(second) )
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)
                    solver.push()
                    solver.add(Not(second == 0))
                    if util.check_satisfiability(solver) == UNSAT_RESULT:
                        computed = 0
                    else:
                        solver.push()
                        solver.add( Not( And(first == -2**255, second == -1 ) ))
                        if util.check_satisfiability(solver) == UNSAT_RESULT:
                            computed = -2**255
                        else:
                            solver.push()
                            solver.add(first / second < 0)
                            sign = -1 if util.check_satisfiability(solver) == SAT_RESULT else 1
                            z3_abs = lambda x: If(x >= 0, x, -x)
                            first = z3_abs(first)
                            second = z3_abs(second)
                            computed = sign * (first / second)
                            solver.pop()
                        solver.pop()
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "NOT":
            if len(stack) > 0:
                first = stack.pop(0)
                computed = (~first) & UNSIGNED_BOUND_NUMBER
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "AND":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                computed = first & second
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "OR":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                computed = first | second
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "INVALID":
            ins = ins + 1
            return
        elif op_code == "ADDRESS":
            stack.insert(0,global_state['call_data_address'])
            ins = ins + 1
        elif op_code == "BALANCE":
            if len(stack) > 0:
                address = stack.pop(0)
            
                if util.is_real(address):
                    hashed_address = "concrete_address_" + str(address)
                else:
                    hashed_address = str(address)

                if hashed_address not in self.balance_map:
                    new_var = BitVec(hashed_address, 256)
                    self.balance_map[hashed_address] = new_var
                stack.insert(0, self.balance_map[hashed_address])
            else:
                raise ValueError('STACK underflow')
        elif op_code == "RETURNDATASIZE":
            new_var_name = "call_return_data"
            new_var = BitVec(new_var_name, 256)
            stack.insert(0, new_var)
            ins = ins + 1
        elif op_code == "RETURNDATACOPY":
            if len(stack) > 2:
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "ORIGIN":
            stack.insert(0, global_state['origin'])
            ins = ins + 1
        elif op_code == "CODESIZE":
            file_path = "./bin-full/" + self.name + ".bin"
            with open(file_path,'r') as temp:
                lenthOfFile = len(temp.read())/2
                stack.insert(0,lenthOfFile)
                temp.close()
            ins = ins + 1
        elif op_code == "GAS":
            stack.insert(0,global_state['gas'])
            ins = ins + 1
        elif op_code == "EXTCODESIZE":
            address = stack.pop(0)
            size = BitVec("code_size", 256)
            stack.insert(0,size)
            ins = ins + 1
        elif op_code == "MSTORE":
            if len(stack) > 1:
                stored_address = stack.pop(0)
                stored_value = stack.pop(0)
                if util.is_real(stored_address):
                    if stored_address > MEM_SIZE - 32:
                        self.write_msg("beyond size")
                    else:
                        meminfo = {
                            "start": stored_address,
                            "end": stored_address + 31,
                            "value": stored_value
                        }
                        self.add_mem_info(meminfo)
                else:
                    self.mem_symbolic[str(stored_address)] = stored_value
            else:
                raise ValueError('STACK underflow')
        elif op_code =="MSTORE8":
            if len(stack) > 1:
                stored_address = stack.pop(0)    
                stored_value = stack.pop(0)
                if util.is_real(stored_address):
                    if stored_address > MEM_SIZE - 1:
                        self.write_msg("beyond size")
                    else:
                        meminfo = {
                            "start": stored_address,
                            "end": stored_address,
                            "value": stored_value
                        }
                        self.add_mem_info(meminfo)
                else:
                    self.mem_symbolic[str(stored_address)] = stored_value
                
            else:
                raise ValueError('STACK underflow')
            
        elif op_code == "MLOAD":
            if len(stack) > 0:
                stored_address = stack.pop(0)
                if util.is_real(stored_address):
                    flag,info = self.load_mem_info(stored_address,stored_address + 31)
                    if not flag:
                        var_name =  variable_generator.generate_arbitrary_MSTORE_variable()
                        new_var = BitVec(var_name, 256)
                        stack.insert(0,new_var)
                    else:
                        stack.insert(0,info["value"])
                else:
                    if not str(stored_address) in self.mem_symbolic:
                        var_name =  variable_generator.generate_arbitrary_MSTORE_variable()
                        new_var = BitVec(var_name, 256)
                        self.mem_symbolic[str(stored_address)] = new_var
                    stack.insert(0, self.mem_symbolic[str(stored_address)])
                
        elif op_code == "CALLDATACOPY":
            if len(stack) > 2:
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
            
        elif op_code == "GASPRICE":
            stack.insert(0,global_state['gasprice'])
            
        elif op_code == "BLOCKHASH":
            blocknumber = stack.pop(0)
            stack.insert(0,global_state['blockhash'])
            
        elif op_code == "COINBASE":
            stack.insert(0,global_state['coinbase'])
            
        elif op_code == "NUMBER":
            stack.insert(0,global_state['number'])
            
        elif op_code == "DIFFICULTY":
            stack.insert(0,global_state['difficulty'])
            
        elif op_code == "GASLIMIT":
            stack.insert(0,global_state['gaslimit'])
            
        elif op_code == "SELFDESTRUCT":
            if len(stack) > 0:
                recipient = stack.pop(0)
                if util.is_symbolic(recipient):
                    recipient = simplify(recipient)
                    money_flow.append(str(recipient),"remain")

                
        elif op_code == "MOD":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.are_all_real(first, second):
                    if second == 0:
                        computed = 0
                    else:
                        first = util.to_unsigned(first)
                        second = util.to_unsigned(second)
                        computed = first % second & UNSIGNED_BOUND_NUMBER
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)

                    solver.push()
                    solver.add(Not(second == 0))
                    if util.check_satisfiability(solver) == UNSAT_RESULT:
                        computed = 0
                    else:
                        computed = URem(first, second)
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                
            else:
                raise ValueError('STACK underflow')
        elif op_code == "XOR":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                computed = first ^ second
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                
            else:
                raise ValueError('STACK underflow')
        elif op_code == "BYTE":
            if len(stack) > 1:
                first = stack.pop(0)
                byte_index = 32 - first - 1
                second = stack.pop(0)

                if util.are_all_real(first, second):
                    if first >= 32 or first < 0:
                        computed = 0
                    else:
                        computed = second & (255 << (8 * byte_index))
                        computed = computed >> (8 * byte_index)
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)
                    solver.push()
                    solver.add( Not (Or( first >= 32, first < 0 ) ) )
                    if util.check_satisfiability(solver) == UNSAT_RESULT:
                        computed = 0
                    else:
                        computed = second & (255 << (8 * byte_index))
                        computed = computed >> (8 * byte_index)
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                
                stack.insert(0, computed)
            else:
                raise ValueError('STACK underflow')
        elif op_code == "CREATE":
            stack.pop(0)
            stack.pop(0)
            stack.pop(0)
            create_res = BitVec("create_res", 256)
            stack.insert(0,create_res)
            
        elif op_code == "SSTORE":
            if len(stack) > 1:
                stored_address = stack.pop(0)
                stored_value = stack.pop(0)
                if util.is_real(stored_address):
                    self.store_real[stored_address] = stored_value
                else:
                    self.store_symbolic[str(stored_address)] = stored_value
                    if util.is_symbolic(stored_value):
                        self.store_map[ins] = stored_value
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SLOAD":
            if len(stack) > 0:
                position = stack.pop(0)
                if util.is_real(position) and position in self.store_real:
                    value = self.store_real[position]
                    stack.insert(0, value)
                else:
                    if str(position) in self.store_symbolic:
                        value = self.store_symbolic[str(position)]
                        stack.insert(0, value)
                    else:
                        if is_expr(position):
                            position = simplify(position)
                        new_var_name = variable_generator.generate_owner_store_variable(position,"storevalue")
                        new_var = BitVec(new_var_name, 256)
                        stack.insert(0,new_var)
                        if util.is_real(position):
                            self.store_real[position] = new_var
                        else:
                            self.store_symbolic[str(position)] = new_var
                
            else:
                raise ValueError('STACK underflow')
        elif op_code == "CALL":
            if len(stack) > 0:
                outgas = stack.pop(0)
                recipient = stack.pop(0)
                transfer_amount = stack.pop(0)
                start_data_input = stack.pop(0)
                size_data_input = stack.pop(0)
                start_data_output = stack.pop(0)
                size_data_ouput = stack.pop(0)

                if util.is_symbolic(recipient):
                    recipient = simplify(recipient)
                
                self.money_flow_path.append((str(recipient),str(transfer_amount)))

                res = BitVec("call_res", 256)
                stack.insert(0,res)
        elif op_code == "CALLVALUE":
            callvalue = BitVec("call_value", 256)
            stack.insert(0,callvalue)
            
        elif op_code in ("DELEGATECALL", "STATICCALL"):
            if len(stack) > 5:
                
                stack.pop(0)
                recipient = stack.pop(0)
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
                res = BitVec("dscall_res", 256)
                stack.insert(0,res)
        elif op_code == "CODECOPY":
            mem_location = stack.pop(0)
            code_from = stack.pop(0)
            no_bytes = stack.pop(0)
            
        elif op_code == "TIMESTAMP":
            stack.insert(0,global_state['timestamp'])
            
        elif op_code == "STOP":
            pass
        elif op_code == "SHA3":
            offset = stack.pop(0)
            size = stack.pop(0)
            if util.are_all_real(offset,size):
                flag,valueList = self.load_size_mem_info(offset,offset+size-1)
                if flag:
                    self.check_Bad_Randomness(valueList)
            res = BitVec("sha_res", 256)
            stack.insert(0,res)
            
        elif op_code == "JUMPDEST":
            
            pass

        elif op_code == "JUMPI":
            if len(stack) > 1:
                target_address = stack.pop(0)
                if util.is_symbolic(target_address):
                    try:
                        target_address = int(str(simplify(target_address)))
                    except:
                        raise TypeError("Target address must be an integer")
                block.set_jump_target(target_address)

                if not self.has_edges(edges,block.get_start_address(),target_address):
                    self.add_edges(edges,block.get_start_address(),target_address)
                
                flag = stack.pop(0)
                branch_expression = (BitVecVal(0, 1) == BitVecVal(1, 1))
                if util.is_real(flag):
                    if flag != 0:
                        branch_expression = True
                else:
                    branch_expression = (flag != 0)
                block.set_branch_expression(branch_expression)

            
        else:
            msg = "missing opcode>>>>>>>  " + op_code + "  " + self.name
            self.write_msg(msg)
                    
    def add_mem_info(self, meminfo):
        """
        Add new memory information to mem_real, ensuring no overlap with existing memory blocks.
        """
        self.mem_real = [
            info for info in self.mem_real
            if not (meminfo["start"] <= info["end"] and meminfo["end"] >= info["start"])
        ]
        self.mem_real.append(meminfo)

    def load_mem_info(self, start, end):
        """
        Load memory info for a specific start and end address.
        Returns (True, info) if found, otherwise (False, {}).
        """
        return next(
            ((True, info) for info in self.mem_real if info["start"] == start and info["end"] == end),
            (False, {})
        )

    def load_size_mem_info(self, start, end):
        """
        Load all memory blocks that fit entirely within the start and end range.
        Returns (flag, result) where flag indicates if any blocks are found.
        """
        result = [info for info in self.mem_real if start <= info["start"] and info["end"] <= end]
        return bool(result), result

    def get_block(self, tag, ctag):
        """
        Retrieve the block with the specified tag from either blocks_c or blocks_r based on ctag.
        Returns the block if found, otherwise returns False.
        """
        blocks = self.blocks_c if ctag else self.blocks_r
        return next((block for block in blocks if block.get_start_address() == tag), False)

    def check(self):
        """
        Perform all checks by initializing the graph and invoking individual vulnerability checks.
        """
        self.initialize_graphs()
        self.run_all_checks()

    def initialize_graphs(self):
        """
        Initialize both the forward and reverse graph for depth-first search.
        """
        self.initDfs_graph()
        self.initDfs_graph_reverse()

    def run_all_checks(self):
        """
        Sequentially run all vulnerability checks.
        """
        checks = [
            self.check_SAA,
            self.check_SLF,
            self.check_UEC,
            self.check_DOS,
            self.check_path_condition,
            self.check_REC,
            self.check_TOD
        ]
        for check in checks:
            check()

    def get_integer_over(self):
        return self.integer_over
    
    def get_integer_under(self):
        return self.integer_under
    
    def get_TOD(self):
        return self.TOD

    def get_REC(self):
        return self.REC
    
    def get_UEC(self):
        return self.UEC
    
    def get_ORI(self):
        return self.ORI
    
    def get_DOS(self):
        return self.DOS
    
    def get_SLF(self):
        return self.SLF
    
    def get_RAD(self):
        return self.RAD
    
    def get_BID(self):
        return self.BID

    def get_SAA(self):
        return self.SAA
    
    def check_inter_overflow(self, first, computed, second, block):
        """
        Check for integer overflow by evaluating symbolic expressions in a block.
        """
        if not preCheck.pre_check_IOF(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        if util.is_real(first) or util.is_real(second):
            return
        
        data_load_flag = 0
        
        data_load_flag = self._check_dataload_flag(first, data_load_flag)

        if data_load_flag == 2:
            return
        
        data_load_flag = self._check_dataload_flag(second, data_load_flag)

        if data_load_flag == 2:
            return
        
        if not data_load_flag:
            return
        
        newsolver = Solver()
        newsolver.add(UGT(first, computed))

        if preCheck.check_need_addconstraint(self.index):
            self._add_path_condition_constraints(newsolver, block, first, second)

        if util.check_satisfiability(newsolver) == SAT_RESULT:
            self.integer_over = True
        del newsolver
    
    def check_inter_underflow(self, first, second, block):
        """
        Check for integer underflow by evaluating symbolic expressions in a block.
        """
        if not preCheck.pre_check_IUF(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        if util.is_real(first) or util.is_real(second):
            return
        
        data_load_flag = 0
        
        data_load_flag = self._check_dataload_flag(first, data_load_flag)

        if data_load_flag == 2:
            return
        
        data_load_flag = self._check_dataload_flag(second, data_load_flag)

        if data_load_flag == 2:
            return
        
        if not data_load_flag:
            return

        newsolver = Solver()
        newsolver.add(UGT(second, first))

        if preCheck.check_need_addconstraint(self.index):
            self._add_path_condition_constraints(newsolver, block, first, second)

        if util.check_satisfiability(newsolver) == SAT_RESULT:
            self.integer_under = True
        del newsolver
    
    def _check_dataload_flag(self, var, flag):
        """
        Check if symbolic variables are related to call data or keccak256 (sha_res).
        """

        if util.is_symbolic(var):
            if var.sexpr() in self.call_data_map:
                flag =  1
            if 'sha_res' in str(var).replace(' ', '') or str(var).isdigit():
                return 2
        return flag

    def _add_path_condition_constraints(self, newsolver, block, first, second):
        """
        Add path condition constraints to the solver.
        """
        for constraint in block.get_path_condition():
            pathVar = str(constraint).replace(' ', '')
            if str(first).replace(' ', '') in pathVar and str(second).replace(' ', '') in pathVar:
                newsolver.add(constraint)
                break
    
    def check_path_condition(self):
        """
        Iterate over the path conditions and check each for BID-related symbols.
        """
        for constraint in self.path_condition:   
            self._check_and_set_BID(constraint)

    def _check_and_set_BID(self, constraint):
        """
        Check if a given constraint contains specific block-related symbols and set BID flag.
        """
        if not is_expr(constraint):
            return
        
        symbols_to_check = ["blockhash", "timestamp", "number"]
        
        if any(self.contains_symbol(constraint, symbol) for symbol in symbols_to_check):
            self.BID = True
    
    def contains_symbol(self,expr,symbol_name):

        """
        Recursively checks if the given expression contains the specified symbol.
        """

        if is_app(expr) and expr.decl().kind() == Z3_OP_UNINTERPRETED:
            if expr.decl().name() == symbol_name:
                return True
        a = expr.children()
        for child in expr.children():
            if self.contains_symbol(child, symbol_name):
                return True

        return False

    def check_ORI(self, expression):
        """
        Checks if the expression contains the 'origin' symbol and sets the ORI flag to True if found.
        """
        if self.contains_symbol(expression, "origin"):
            self.ORI = True

    def check_EQ(self,expression):

        self.check_ORI(expression)
 
    def check_UEC(self):
        """
        This method checks for Unchecked External Call (UEC) vulnerabilities in the contract code.

        It first performs a pre-check based on the Solidity source file to identify any potential
        patterns that could indicate the presence of UEC vulnerabilities. If such patterns are detected,
        the method proceeds to inspect the runtime blocks for any "CALL" operations that are not 
        sufficiently protected by symbolic conditions or checks.
        """
        
        # Pre-check for UEC patterns in the Solidity source file
        if not preCheck.pre_check_UEC(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        # Iterate over the runtime blocks to find potential vulnerabilities
        for block_r in self.blocks_r:
            # Retrieve the list of instructions for the current block
            for ins in block_r.get_instructions():
                op_code = self.op_dict_r[ins]
                
                # Only proceed if the instruction is a CALL operation
                if op_code != "CALL":
                    continue

                # Set a flag to monitor potential vulnerabilities
                flag = False

                # Get the potential execution path for the current block
                potential_path = self.get_potential_path(block_r.get_start_address())
                potential_path.add(block_r.get_start_address())

                # Check the path condition constraints and symbolic expressions in the blocks along the potential path
                for k in potential_path:
                    block_k = self.get_block(k, False)

                    # Evaluate path condition constraints for symbolic "call_res" usage
                    for constraint in block_k.get_path_condition():
                        if util.is_symbolic(constraint) and self.contains_symbol(constraint, "call_res"):
                            flag = True
                            break

                    # Check for zero expressions, ensuring the block has this method available
                    if not hasattr(block_k, 'get_is_zero_expressions'):
                        return

                    # Evaluate symbolic expressions for unchecked "call_res" usage
                    iszero_expressions = block_k.get_is_zero_expressions()
                    for expression in iszero_expressions:
                        if self.contains_symbol(expression, "call_res"):
                            flag = True
                            break

                # If no protective checks are found, mark the UEC vulnerability
                if not flag:
                    self.UEC = True
         
    def check_DOS(self):
        """
        This method checks for Denial of Service (DOS) vulnerabilities in the contract code.

        It first performs a pre-check to identify potential DOS vulnerability patterns based on the 
        Solidity source file. If such patterns are detected, the method proceeds to construct a graph 
        from the runtime block edges, detects any cycles in the graph, and inspects the blocks involved 
        in those cycles for the presence of "CALL" operations, which could indicate potential DOS issues.
        """
        
        # Pre-check for DOS patterns in the Solidity source file
        if not preCheck.pre_check_DOS(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        # Initialize a graph to analyze the edges between runtime blocks
        graph = Graph()

        # Add edges to the graph from runtime block edges
        for edge in self.edges_r:
            for from_node in edge:
                graph.add_edge(from_node, edge[from_node])

        # Collect all node addresses from runtime blocks
        all_nodes = [block.get_start_address() for block in self.blocks_r]

        # Detect cycles in the graph using topological sorting
        cycle_nodes = graph.detect_cycles_via_topological_sort(all_nodes)

        # If no significant cycles are detected, exit the method
        if len(cycle_nodes) <= 1:
            return

        # Find all cycles in the graph
        cycles = graph.find_all_cycles()

        # Inspect each cycle to determine if it contains a "CALL" operation
        for cycle in cycles:
            for index in cycle:
                block = self.get_block(index, False)
                block_instructions = block.get_instructions()
                for instruction in block_instructions:
                    if self.op_dict_r[instruction] == "CALL":
                        self.DOS = True
                        break

    def check_REC(self):
        
        """
        This method checks for Reentrancy vulnerabilities (REC) in the contract by analyzing 
        the execution blocks and instructions. The method identifies symbolic constraints related 
        to the caller's address and checks for write operations (SSTORE) that might affect stored 
        variables potentially vulnerable to reentrancy.
        """

        # Pre-check for Reentrancy patterns in the Solidity source file
        if not preCheck.pre_check_REC(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        # Iterate through each runtime block and analyze its instructions
        for block_r in self.blocks_r:
            insList = block_r.get_instructions()

            # Check for "CALL" opcode in the instructions
            for ins in insList:
                op_code = self.op_dict_r[ins]
                if op_code != "CALL":
                    continue

                # Check if the path condition contains any symbolic references to "caller_address"
                for constraint in block_r.get_path_condition():
                    if util.is_symbolic(constraint) and self.contains_symbol(constraint, "caller_address"):
                        return

                # Get the potential paths for the current block
                potential_path = self.get_potential_path(block_r.get_start_address())

                # Analyze instructions along the potential path for the "SSTORE" operation
                for path_index in potential_path:
                    block_k = self.get_block(path_index, False)
                    block_k_instructions = block_k.get_instructions()

                    # Check for "SSTORE" opcode and inspect the stored variables
                    for kins in block_k_instructions:
                        if self.op_dict_r[kins] == "SSTORE" and kins in self.store_map:
                            store_var = str(self.store_map[kins]).replace(' ', '')
                            
                            # Ensure the stored variable is related to "Ia_store"
                            if "Ia_store" not in store_var:
                                continue
                            
                            # Check if the stored variable appears in the path condition
                            for constraint in self.path_condition:
                                path_var = str(constraint).replace(' ', '')
                                if store_var in path_var:
                                    self.REC = True
                                    return
                                
    def check_SLF(self):
        
        """
        This method checks for the presence of the "SELFDESTRUCT" opcode in the runtime blocks,
        which can indicate potential vulnerabilities related to unauthorized destruction of 
        the contract. The method analyzes path conditions and reverse paths for symbolic references 
        to the "caller_address" to determine if the destruction is authorized.
        """

        # Pre-check to detect potential SELFDESTRUCT vulnerabilities from the Solidity source file
        if not preCheck.pre_check_SLF(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        # Iterate through each runtime block and analyze its instructions
        for block_r in self.blocks_r:
            r_instructions = block_r.get_instructions()

            # Check for the presence of the "SELFDESTRUCT" opcode in the instructions
            for ins in r_instructions:
                if self.op_dict_r[ins] != "SELFDESTRUCT":
                    continue

                flag = False

                # Analyze the block's path condition for symbolic references to "caller_address"
                for constraint in block_r.get_path_condition():
                    if util.is_symbolic(constraint) and self.contains_symbol(constraint, "caller_address"):
                        flag = True

                # Retrieve the potential reverse path and check for symbolic constraints in eq expressions
                potential_path_reverse = self.get_potential_path_reverse(block_r.get_start_address())
                for path_index in potential_path_reverse:
                    block_k = self.get_block(path_index, False)
                    eq_expressions = block_k.get_eq_expressions()

                    # Check if any equality expressions contain the "caller_address" symbol
                    for expression in eq_expressions:
                        if self.contains_symbol(expression, "caller_address"):
                            flag = True
                            break

                # If no flag was raised, mark the SLF (SELFDESTRUCT vulnerability) as detected
                if not flag:
                    self.SLF = True

    def check_Bad_Randomness(self, infoList):
        
        """
        This method checks for the presence of potential bad randomness sources within the provided 
        information list. It flags the use of symbolic variables related to on-chain randomness sources 
        like block number, difficulty, or timestamp, which may lead to unpredictable or exploitable behavior.
        """

        # Pre-check to detect potential bad randomness usage from the Solidity source file
        if not preCheck.pre_check_RAD(SOLFILE_PATH + "output_" + str(self.index) + ".sol"):
            return

        # Iterate through the list of symbolic information to assess potential randomness issues
        for info in infoList:
            # Check if the value is symbolic
            if util.is_symbolic(info["value"]):
                # Check for "blockhash" dependency and set the BID flag if necessary
                self._check_and_set_BID(info["value"])

                # Check if the symbolic value depends on block-related randomness sources
                if (self.contains_symbol(info["value"], "number") or
                    self.contains_symbol(info["value"], "difficulty") or
                    self.contains_symbol(info["value"], "timestamp")):
                    # Flag the potential use of bad randomness
                    self.RAD = True
            
    def check_SAA(self):
        
        """
        This method checks for the presence of solid addresses in the Solidity source file. 
        It searches for hexadecimal strings that match the format of Ethereum addresses, and flags 
        the contract if such an address is found.
        """
        # Read the Solidity source file
        with open(SOLFILE_PATH + "output_" + str(self.index) + ".sol", 'r', encoding='utf-8') as file:
            content = file.read()
        
        # Use a regular expression to search for Ethereum-like addresses in the source code
        matches = re.findall(r'^0x[0-9a-fA-F]{1,39}$', content)

        # If a solid address is found, flag the contract for potential issues
        if matches:
            self.SAA = True
    
    def check_TOD(self):
        
        """
        This method checks for transaction order dependency (TOD) vulnerabilities by analyzing 
        the contract's money flow paths. If the contract contains inconsistent flows of monetary 
        transactions, it flags the contract for potential TOD risks.
        """
        # Initialize the iteration counter
        i = 0
        
        # Iterate through the list of money flow paths
        for flow in self.money_flow_path:
            i += 1
            # Skip the analysis if the flow contains only one transaction
            if len(flow) == 1:
                continue 
        
        # Check subsequent flows for inconsistencies starting from the ith index
        for j in range(i, len(self.money_flow_path)):
            jflow = self.money_flow_path[j]
            # Skip if the flow contains only one transaction
            if len(jflow) == 1:
                continue
            # Check if the current flow differs from the previous flow, indicating a TOD vulnerability
            if util.is_different(flow, jflow):
                self.TOD = True
                break
    
    def has_edges(self, edges, anode, bnode):
        """
        This method checks if an edge exists between two nodes in the given list of edges.
        
        Args:
            edges (list): A list of edges represented as dictionaries, where keys are the source nodes 
                        and values are the destination nodes.
            anode (Any): The source node to check.
            bnode (Any): The destination node to check.
        
        Returns:
            bool: True if an edge from 'anode' to 'bnode' exists, otherwise False.
        """
        # Iterate over the list of edges to check for a matching edge from 'anode' to 'bnode'
        for edge in edges:
            if anode in edge and edge[anode] == bnode:
                return True
        return False

    def add_edges(self, edges, anode, bnode):
        """
        This method adds a new edge between two nodes to the given list of edges.
        
        Args:
            edges (list): A list of edges where the new edge will be added.
            anode (Any): The source node.
            bnode (Any): The destination node.
        
        Returns:
            None
        """
        # Create a dictionary representing the new edge and append it to the list of edges
        edge_info = {anode: bnode}
        edges.append(edge_info)

    def initDfs_graph(self):
        """
        This method initializes the forward-directed depth-first search (DFS) graph.
        It constructs a graph where each block's start address maps to a set of destination nodes
        based on the edge information from the reverse blocks.
        
        Returns:
            None
        """
        # Iterate through each block in the reverse blocks list and create the graph structure
        for block in self.blocks_r:
            self.graph_dict[block.get_start_address()] = set()
            # Add edges where the block's start address is the source
            for edge in self.edges_r:
                if list(edge.keys())[0] == block.get_start_address():
                    self.graph_dict[block.get_start_address()].add(list(edge.values())[0])

    def initDfs_graph_reverse(self):
        
        """
        This method initializes the reverse-directed depth-first search (DFS) graph.
        It constructs a graph where each block's start address maps to a set of source nodes
        based on the edge information from the reverse blocks.
        
        Returns:
            None
        """
        # Iterate through each block in the reverse blocks list and create the reverse graph structure
        for block in self.blocks_r:
            self.graph_dict_reverse[block.get_start_address()] = set()
            # Add edges where the block's start address is the destination
            for edge in self.edges_r:
                if list(edge.values())[0] == block.get_start_address():
                    self.graph_dict_reverse[block.get_start_address()].add(list(edge.keys())[0])

    def _get_potential_path(self, tag, graph):
        """
        Helper function to find potential paths based on the given graph.
        """
        potential_path = set()
        s = [tag]
        while s:       
            vertex = s.pop()   
            if vertex not in potential_path:
                potential_path.add(vertex)
                if vertex in graph:
                    s.extend(graph[vertex] - potential_path)
        potential_path.remove(tag)

        return potential_path

    def get_potential_path(self, tag):
        """
        Find the potential path starting from the given tag in the forward graph.
        """
        return self._get_potential_path(tag, self.graph_dict)

    def get_potential_path_reverse(self, tag):
        """
        Find the potential path starting from the given tag in the reverse graph.
        """
        return self._get_potential_path(tag, self.graph_dict_reverse)
    
    def is_valid_function_signature(self, s):
        
        # Check if the string starts with '0x' and has exactly 10 characters
        if not (s.startswith("0x") and len(s) == 10):
            return False

        # Try to convert the part after '0x' to a hexadecimal integer
        try:
            int(s[2:], 16)  # Skip '0x' and check if the rest is a valid hex
        except ValueError:
            return False

        return True
    
    def write_msg(self,msg):
        with open("./error.log",'a') as f:
            f.write(msg)
            f.write('\n')
            f.close()
    
    def __del__(self):
        return


# test = SmartContractAnalyzer("MathLib_699",699,"0x123")
# # print(test.get_ORI())
# print(test.get_integer_under())
# print(test.get_integer_over())

# print(preCheck.check_need_addconstraint(114))