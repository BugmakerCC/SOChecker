import re
from web3 import Web3
import networkx as nx
import matplotlib.pyplot as plt

from z3 import *

import calculate as cal
from baseBlock import BasicBlock
from graph import Graph
from checkUnit import CheckUnit

import utils as util
from generator import *

sat = CheckSatResult(Z3_L_TRUE)
unsat = CheckSatResult(Z3_L_FALSE)
unknown = CheckSatResult(Z3_L_UNDEF)

max_depth = 300
                
gas = "0x1b0a39"

creation_path = "./opcodes-creation/"

creation_postfix = ".opcodes-creation"

run_path = "./opcodes-runtime/"

run_postfix = ".opcodes-runtime"

global solver
solver = Solver()

global gen
gen = Generator()


UNSIGNED_BOUND_NUMBER = 2**256 - 1
CONSTANT_ONES_159 = BitVecVal((1 << 160) - 1, 256)

store_real = {}
store_symbolic = {}


memory = []

mem= {}

global_state = {
    'caller_address' : BitVec("caller_address", 256),
    'data_load' : BitVec("data_load", 256),
    'data_size' : BitVec("data_size", 256),
    'call_data_address' : BitVec("call_data_address", 256),
    'gas' : BitVec("gas", 256),
    'selfbalance' : BitVec("selfbalance", 256),
    'coinbase' : BitVec("coinbase", 256),
    'difficulty' : BitVec("difficulty", 256),
    'gaslimit' : BitVec("gaslimit", 256),
    'timestamp' : BitVec("timestamp", 256),
    'number' : BitVec("number", 256),
    'gasprice' : BitVec("gasprice", 256),
    'blockhash' : BitVec("blockhash", 256),
    'origin' : BitVec("origin", 256),
    'chainid' : BitVec("chainid", 256),
    'codehash' : BitVec("codehash", 256),
    'msize' : 0
}

balance_map = {}

path_condition = []

class contract:

    def __init__(self, name):

        self.name = name

        self.storage = {} 

        self.op_dict_c = {}

        self.op_dict_r = {}

        self.value_dict_c = {}

        self.value_dict_r = {}

        self.blocks_c = []

        self.blocks_r = []

        self.edges_c = []

        self.edges_r = []
        
        self.visited = []
        
        self.stack = []

        self.graph_dict = {}

        self.owner_key = -1

        self.owner_value = ""

        self.SP = False

        self.SSP = False

        self.STP = False

        self.TS = False

        self.FT = False

        self.UEC = False

        self.ORI = False

        self.SLF = False

        self.BID = False

        self.HCA = False

        self.SBE = False

        self.NC = False

        self.depth = 0 

        self.overflow = False
        
        self.integer_over = False

        self.integer_under = False
        
        self.process()

        self.check()

        # try:
        #     #preprocess
        #     self.process()
        # #check
        #     self.check()
        # except Exception as e:
        #     self.write_msg1("build cfg error " + e.__str__() + "  " + self.name)


    def process(self):
        c_path = creation_path + self.name + creation_postfix
        r_path = run_path + self.name + run_postfix
        self.construct_cfg(c_path,self.op_dict_c,self.value_dict_c,self.blocks_c,self.edges_c)
        self.symbolic_exec_block(0,True,self.stack,self.op_dict_c,self.value_dict_c,self.edges_c)
        self.visited.clear()
        self.stack.clear()
        self.depth = 0
        while solver.num_scopes() > 0:
            solver.pop()  
        self.construct_cfg(r_path,self.op_dict_r,self.value_dict_r,self.blocks_r,self.edges_r)
        self.symbolic_exec_block(0,False,self.stack,self.op_dict_r,self.value_dict_r,self.edges_r)

    def construct_cfg(self,file_path,op_dict,value_dict,blocks,edges):
        op_list = []
        move_firstLine = False
        with open(file_path, 'r') as disasm_file:
            while True:
                line = disasm_file.readline()
                if not move_firstLine:
                    move_firstLine = True
                    continue  
                if not line:
                    break
                str_list = line.split(' ')
                str_pc = str_list[0]
                pc = str_pc.replace(":", "", 1)

                try:
                    pc = int(pc, 16)
                except:
                    self.write_msg("opcodes error>> " + self.name)
                    return
                #pc = int(pc)
                opcode = str_list[1].strip()

                if opcode == "Missing":
                    opcode = "INVALID"
                if opcode == "KECCAK256":
                    opcode = "SHA3"
                if opcode == "opcode":
                    opcode = "INVALID"

                op_dict[pc] = opcode
                if len(str_list) > 2 and opcode != "INVALID":
                    str_value = str_list[-1].strip()
                    value_dict[pc] = str_value

                if opcode == "STOP" or opcode == "JUMP" or opcode == "JUMPI" or opcode == "RETURN" or opcode == "SUICIDE" or opcode == "REVERT" or opcode == "ASSERTFAIL":
                    op_ele = {}
                    op_ele['pc'] = pc
                    op_ele['opcode'] = opcode
                    op_ele['depart'] = False
                    op_list.append(op_ele)

                    op_dp = {}
                    op_dp['depart'] = True
                    op_list.append(op_dp)
                elif opcode == "JUMPDEST":
                    if op_list[op_list.__len__() - 1]['depart'] == False:
                        op_dp = {}
                        op_dp['depart'] = True
                        op_list.append(op_dp)

                    op_ele = {}
                    op_ele['pc'] = pc
                    op_ele['opcode'] = opcode
                    op_ele['depart'] = False
                    op_list.append(op_ele)
                else:
                    op_ele = {}
                    op_ele['pc'] = pc
                    op_ele['opcode'] = opcode
                    op_ele['depart'] = False
                    op_list.append(op_ele)
            if op_list.__len__() == 0:
                return
            if(op_list[-1]['depart'] == False):
                op_dp = {}
                op_dp['depart'] = True
                op_list.append(op_dp)

            start_line = 0
            new_block = True

            for i,op_ele in enumerate(op_list):
                if new_block:
                    block = BasicBlock(start_line)
                    new_block = False
                if not op_ele['depart']:
                    block.add_instruction(op_ele['pc'])
                    continue
                block.set_end_address(op_list[i-1]['pc'])
                blocks.append(block)
                new_block = True
                if (i+1 < op_list.__len__()):
                    start_line = op_list[i+1]['pc']
            for i,block in enumerate(blocks):
                if(op_dict[block.get_end_address()] == "JUMPI"):
                    block.set_block_type("conditional")
                elif (op_dict[block.get_end_address()] == "JUMP"):
                    block.set_block_type("unconditional")
                elif (op_dict[block.get_end_address()] == "STOP" or op_dict[block.get_end_address()] == "RETURN" or op_dict[block.get_end_address()] == "SUICIDE" or op_dict[block.get_end_address()] == "REVERT" or op_dict[block.get_end_address()] == "ASSERTFAIL"):
                    block.set_block_type("terminal")
                else:
                    block.set_block_type("fall_to")
            for i, block in enumerate(blocks):
                for j, fall_block in enumerate(blocks):
                    if(block.get_block_type() != "unconditional" and block.get_block_type() != "terminal" and fall_block.get_start_address() == block.get_end_address() + 1):
                        block.set_fall_to(fall_block.get_start_address())
                        edge_info = {}
                        edge_info[block.get_start_address()] = fall_block.get_start_address()
                        edges.append(edge_info)

    def symbolic_exec_block(self,tag,ctag,stack,op_dict,value_dict,edges):
        
        global solver
        
        self.depth = self.depth + 1
        if (self.depth > max_depth):
            msg = "depth max " + self.name
            # self.write_msg(msg)
            if not self.overflow:
                self.overflow = True
            return
        block = self.get_block(tag,ctag)
        if not block:
            return
        
        for i,ins in enumerate(block.get_instructions()):
            self.symbolic_exec_ins(block,ins,stack,op_dict,value_dict,edges,ctag)

        if block.get_block_type() == "terminal" or self.depth > max_depth:
            return
        elif block.get_block_type() == "unconditional":
            successor = block.get_jump_target()
            self.symbolic_exec_block(successor,ctag,stack,op_dict,value_dict,edges)
        elif block.get_block_type() == "fall_to":
            successor = block.get_fall_to()
            self.symbolic_exec_block(successor,ctag,stack,op_dict,value_dict,edges)
        elif block.get_block_type() == "conditional":

            branch_expression = block.get_branch_expression()
            solver.push() 
            solver.add(branch_expression)


            try:
                if solver.check() == unsat:
                    self.write_msg("INFEASIBLE PATH DETECTED")
                else:
                    path_condition.append(branch_expression)
                    left_branch = block.get_jump_target()
                    self.symbolic_exec_block(left_branch,ctag,stack,op_dict,value_dict,edges)
            except TimeoutError:
                raise
            except Exception as e:
                    self.write_msg("z3 error" + e.__str__())
                
            solver.pop()    
            solver.push()  
            negated_branch_expression = Not(branch_expression)
            solver.add(negated_branch_expression)
            
                
            try:
                if solver.check() == unsat:
                    self.write_msg("INFEASIBLE PATH DETECTED")
                else:
                    right_branch = block.get_fall_to()
                    path_condition.append(negated_branch_expression)
                    self.symbolic_exec_block(right_branch,ctag,stack,op_dict,value_dict,edges)
            except TimeoutError:
                raise
            except Exception as e:
                    self.write_msg("z3 error" + e.__str__())


    def symbolic_exec_ins(self,block,ins,stack,op_dict,value_dict,edges,ctag):

        op_code = op_dict[ins]
        if op_code.startswith("PUSH"):
            if value_dict.__contains__(ins):
                pushed_value = int(value_dict[ins], 16)
                stack.insert(0,pushed_value)
            vstr = re.search(r"\d+", op_code).group(0)
            length = int(vstr)
            ins = ins + length + 1
        elif op_code == "CALLDATASIZE":
            stack.insert(0,global_state['data_size'])
            ins = ins + 1
        elif op_code == "CALLDATALOAD":
            if len(stack) > 0:
                position = stack.pop(0)
                stack.insert(0, global_state['data_load'])
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "POP":
            if len(stack) > 0:
                stack.pop(0)
                ins = ins + 1
            else:
                stack.clear()
        elif op_code == "CALLER":
            stack.insert(0,global_state['caller_address'])
            ins = ins + 1
        elif op_code == "CHAINID":
            stack.insert(0,global_state['chainid'])
            ins = ins + 1
        elif op_code == "MSIZE":
            msize = 32 * global_state['msize']
            stack.insert(0,msize)
            ins = ins + 1
        elif op_code == "SIGNEXTEND":
            if len(stack) > 1:
                if util.isAllReal(first, second):
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
                    if util.check_sat(solver) == unsat:
                        computed = second
                    else:
                        signbit_index_from_right = 8 * first + 7
                        solver.push()
                        solver.add(second & (1 << signbit_index_from_right) == 0)
                        if util.check_sat(solver) == unsat:
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

                if util.isAllReal(first, second, third):
                    if third == 0:
                        computed = 0
                    else:
                        computed = (first * second) % third
                else:
                    first = util.to_symbolic(first)
                    second = util.to_symbolic(second)
                    solver.push()
                    solver.add( Not(third == 0) )
                    if util.check_sat(solver) == unsat:
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
                    self.check_EQ(first,block)
                if is_expr(second):
                    self.check_EQ(second,block) 

                if util.isAllReal(first, second):
                    if first == second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    computed = If(first == second, BitVecVal(1, 256), BitVecVal(0, 256))
                    block.add_eqexpression(computed)
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
                ins = ins + 1
        elif op_code.startswith("LOG"):
            vstr = re.search(r"\d+", op_code).group(0)
            num = int(vstr) + 2
            while num > 0:
                stack.pop(0)
                num = num - 1
            ins = ins + 1
        elif op_code == "SELFBALANCE":
            stack.insert(0,global_state['selfbalance'])
            ins = ins + 1
        elif op_code == "SUB":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.isReal(first) and util.isSymbolic(second):
                    first = BitVecVal(first, 256)
                    computed = first - second
                elif util.isSymbolic(first) and util.isReal(second):
                    second = BitVecVal(second, 256)
                    computed = first - second
                else:
                    computed = (first - second) % (2 ** 256)
                computed = simplify(computed) if is_expr(computed) else computed
                check_revert = False
                if block.get_block_type() == 'conditional':
                    if hasattr(block,'jump_target'): 
                        jump_target = block.get_jump_target()
                        jblock = self.get_block(jump_target,ctag)
                        check_revert = any([True for instruction in jblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                    if not check_revert and hasattr(block,'fall_to'): 
                        fall_to = block.get_fall_to()
                        fblock = self.get_block(fall_to,ctag)
                        check_revert = any([True for instruction in fblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                if block.get_block_type() != 'conditional' or not check_revert:
                    self.check_inter_underflow(first,second)
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "ADD":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.isReal(first) and util.isSymbolic(second):
                    first = BitVecVal(first, 256)
                    computed = first + second
                elif util.isSymbolic(first) and util.isReal(second):
                    second = BitVecVal(second, 256)
                    computed = first + second
                else:
                    computed = (first + second) % (2 ** 256)
                computed = simplify(computed) if is_expr(computed) else computed
                check_revert = False
                if block.get_block_type() == 'conditional':
                    if hasattr(block,'jump_target'): 
                        jump_target = block.get_jump_target()
                        jblock = self.get_block(jump_target,ctag)
                        check_revert = any([True for instruction in jblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                    if not check_revert and hasattr(block,'fall_to'): 
                        fall_to = block.get_fall_to()
                        fblock = self.get_block(fall_to,ctag)
                        check_revert = any([True for instruction in fblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                if block.get_block_type() != 'conditional' or not check_revert:
                    self.check_inter_overflow(first,computed)
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "EXP":
            if len(stack) > 1:
                base = stack.pop(0)
                exponent = stack.pop(0)
                if util.isAllReal(base, exponent):
                    computed = pow(base, exponent, 2**256)
                else:
                    new_var_name = gen.gen_arbitrary_var()
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
                if util.isReal(shift) and util.isSymbolic(value):
                    shift = BitVecVal(shift, 256)
                    computed = value >> shift
                elif util.isSymbolic(shift) and util.isReal(value):
                    value = BitVecVal(value, 256)
                    computed = value >> shift
                else:
                    computed = value >> shift
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0,computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SHL":
            if len(stack) > 1:
                shift = stack.pop(0)
                value = stack.pop(0)
                if util.isReal(shift) and util.isSymbolic(value):
                    shift = BitVecVal(shift, 256)
                    computed = value << shift
                elif util.isSymbolic(shift) and util.isReal(value):
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
                if util.isSymbolic(target_address):
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
                new_var_name = gen.gen_arbitrary_var()
                new_var = BitVec(new_var_name, 256)
                stack.insert(0, new_var)
            else:
                raise ValueError('STACK underflow')
        elif op_code == "LT":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.isAllReal(first, second):
                    first = util.to_unsigned(first)
                    second = util.to_unsigned(second)
                    if first < second:
                        computed = 1
                    else:
                        computed = 0
                else:
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
                if util.isAllReal(first, second):
                    first = util.to_unsigned(first)
                    second = util.to_unsigned(second)
                    if first > second:
                        computed = 1
                    else:
                        computed = 0
                else:
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
                if util.isAllReal(first, second):
                    first = util.to_signed(first)
                    second = util.to_signed(second)
                    if first > second:
                        computed = 1
                    else:
                        computed = 0
                else:
                    computed = If(first > second, BitVecVal(1, 256), BitVecVal(0, 256))
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "ISZERO":
            if len(stack) > 0:
                first = stack.pop(0)
                if util.isReal(first): 
                    if first == 0:
                        computed = 1
                    else:
                        computed = 0
                else:
                    computed = If(first == 0, BitVecVal(1, 256), BitVecVal(0, 256))
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SLT":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.isAllReal(first, second):
                    first = util.to_signed(first)
                    second = util.to_signed(second)
                    if first < second:
                        computed = 1
                    else:
                        computed = 0
                else:
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
                if util.isReal(first) and util.isSymbolic(second):
                    first = BitVecVal(first, 256)
                elif util.isSymbolic(first) and util.isReal(second):
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
                if util.isAllReal(first, second):
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
                    if util.check_sat(solver) == unsat:
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
                if util.isAllReal(first, second):
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
                    if util.check_sat(solver) == unsat:
                        computed = 0
                    else:
                        solver.push()
                        solver.add( Not( And(first == -2**255, second == -1 ) ))
                        if util.check_sat(solver) == unsat:
                            computed = -2**255
                        else:
                            solver.push()
                            solver.add(first / second < 0)
                            sign = -1 if util.check_sat(solver) == sat else 1
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
            #-------------------------------------------------
            if len(stack) > 0:
                address = stack.pop(0)
            
                if util.isReal(address):
                    hashed_address = "concrete_address_" + str(address)
                else:
                    hashed_address = str(address)

                if hashed_address not in balance_map:
                    new_var = BitVec(hashed_address, 256)
                    balance_map[hashed_address] = new_var
                stack.insert(0, balance_map[hashed_address])
            else:
                raise ValueError('STACK underflow')
        elif op_code == "RETURNDATASIZE":
            new_var_name = gen.gen_arbitrary_var()
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
            stack.insert(0,gas)
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
                if util.isAllReal(stored_address,stored_value):
                    old_size = len(memory) // 32
                    new_size = util.ceil32(stored_address + 32) // 32
                    mem_extend = (new_size - old_size) * 32
                    memory.extend([0] * mem_extend)
                    value = stored_value
                    for i in range(31, -1, -1):
                        memory[stored_address + i] = value % 256
                        value /= 256
                    global_state['msize'] = new_size
                else:
                    temp = ((stored_address + 31) / 32) + 1
                    expression = global_state['msize'] < temp
                    solver.push()
                    solver.add(expression)
                    if util.check_sat(solver) != unsat:
                        global_state['msize'] = If(expression,temp,global_state['msize'])
                    solver.pop()
                    key = str(stored_address) if util.isSymbolic(stored_address) else stored_address
                    mem[key] = stored_value
            else:
                raise ValueError('STACK underflow')
        elif op_code =="MSTORE8":
            if len(stack) > 1:
                stored_address = stack.pop(0)
                temp_value = stack.pop(0)
                stored_value = temp_value % 256  
                current_msize = global_state["msize"]
                if util.isAllReal(stored_address, stored_value):
                    old_size = len(memory) // 32
                    new_size = util.ceil32(stored_address + 1) // 32
                    mem_extend = (new_size - old_size) * 32
                    memory.extend([0] * mem_extend)
                    memory[stored_address] = stored_value 
                    global_state['msize'] = new_size
                else:
                    temp = (stored_address / 32) + 1
                    expression = current_msize < temp
                    solver.push()
                    solver.add(expression)
                    if util.check_sat(solver) != unsat:
                        current_msize = If(expression,temp,current_msize)
                    solver.pop()
                    key = str(stored_address) if util.isSymbolic(stored_address) else stored_address
                    mem[key] = stored_value
                    global_state["msize"] = current_msize
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
            
        elif op_code == "MLOAD":
            if len(stack) > 0:
                stored_address = stack.pop(0)
                var_name =  gen.gen_arbitrary_var()
                new_var = BitVec(var_name, 256)
                stack.insert(0,new_var)
                if util.isReal(stored_address):
                    if not str(stored_address) in mem:
                        value = 0
                        for i in range(31, -1, -1):
                            value = memory[stored_address + i] * 256 + value
                        stack.insert(0, value)
                else:
                    if str(stored_address) in mem:
                        value = mem[stored_address]
                        stack.insert(0, value)
                ins = ins + 1
        elif op_code == "CALLDATACOPY":
            if len(stack) > 2:
                stack.pop(0)
                stack.pop(0)
                stack.pop(0)
            ins = ins + 1
        elif op_code == "GASPRICE":
            stack.insert(0,global_state['gasprice'])
            ins = ins + 1
        elif op_code == "BLOCKHASH":
            blocknumber = stack.pop(0)
            stack.insert(0,global_state['blockhash'])
            ins = ins + 1
        elif op_code == "COINBASE":
            stack.insert(0,global_state['coinbase'])
            ins = ins + 1
        elif op_code == "NUMBER":
            stack.insert(0,global_state['number'])
            ins = ins + 1
        elif op_code == "DIFFICULTY":
            stack.insert(0,global_state['difficulty'])
            ins = ins + 1
        elif op_code == "GASLIMIT":
            stack.insert(0,global_state['gaslimit'])
            ins = ins + 1
        elif op_code == "SELFDESTRUCT":
            if len(stack) > 0:
                addr = stack.pop(0)
                ins = ins + 1
        elif op_code == "MOD":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                if util.isAllReal(first, second):
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
                    if util.check_sat(solver) == unsat:
                        computed = 0
                    else:
                        computed = URem(first, second)
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "XOR":
            if len(stack) > 1:
                first = stack.pop(0)
                second = stack.pop(0)
                computed = first ^ second
                computed = simplify(computed) if is_expr(computed) else computed
                stack.insert(0, computed)
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
        elif op_code == "BYTE":
            if len(stack) > 1:
                first = stack.pop(0)
                byte_index = 32 - first - 1
                second = stack.pop(0)

                if util.isAllReal(first, second):
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
                    if util.check_sat(solver) == unsat:
                        computed = 0
                    else:
                        computed = second & (255 << (8 * byte_index))
                        computed = computed >> (8 * byte_index)
                    solver.pop()
                computed = simplify(computed) if is_expr(computed) else computed
                ins = ins + 1
                stack.insert(0, computed)
            else:
                raise ValueError('STACK underflow')
        elif op_code == "CREATE":
            stack.pop(0)
            stack.pop(0)
            stack.pop(0)
            create_res = BitVec("create_res", 256)
            stack.insert(0,create_res)
            ins = ins + 1
        elif op_code == "SSTORE":
            if len(stack) > 1:
                ins = ins + 1
                stored_address = stack.pop(0)
                stored_value = stack.pop(0)
                if util.isReal(stored_address):
                    store_real[stored_address] = stored_value
                else:
                    store_symbolic[str(stored_address)] = stored_value
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SLOAD":
            if len(stack) > 0:
                position = stack.pop(0)
                if util.isReal(position) and position in store_real:
                    value = store_real[position]
                    stack.insert(0, value)
                else:
                    if str(position) in store_symbolic:
                        value = store_symbolic[str(position)]
                        stack.insert(0, value)
                    else:
                        if is_expr(position):
                            position = simplify(position)
                        new_var_name = gen.gen_owner_store_var(position,"storevalue")
                        new_var = BitVec(new_var_name, 256)
                        stack.insert(0,new_var)
                        if util.isReal(position):
                            store_real[position] = new_var
                        else:
                            store_symbolic[str(position)] = new_var
                ins = ins + 1
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
                res = BitVec("call_res", 256)
                stack.insert(0,res)
        elif op_code == "CALLVALUE":
            callvalue = BitVec("call_value", 256)
            stack.insert(0,callvalue)
            ins = ins + 1
        elif op_code in ("DELEGATECALL", "STATICCALL"):
            if len(stack) > 5:
                ins = ins + 1
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
            ins = ins + 1
        elif op_code == "TIMESTAMP":
            stack.insert(0,global_state['timestamp'])
            ins = ins + 1
        elif op_code == "STOP":
            ins = ins + 1
        elif op_code == "SHA3":
            offset = stack.pop(0)
            size = stack.pop(0)
            res = BitVec("sha_res", 256)
            stack.insert(0,res)
            ins = ins + 1
        elif op_code == "JUMPDEST":
            ins = ins + 1
        elif op_code == "JUMPI":
            if len(stack) > 1:
                target_address = stack.pop(0)
                if util.isSymbolic(target_address):
                    try:
                        target_address = int(str(simplify(target_address)))
                    except:
                        raise TypeError("Target address must be an integer")
                block.set_jump_target(target_address)

                if not self.has_edges(edges,block.get_start_address(),target_address):
                    self.add_edges(edges,block.get_start_address(),target_address)
                
                flag = stack.pop(0)
                branch_expression = (BitVecVal(0, 1) == BitVecVal(1, 1))
                if util.isReal(flag):
                    if flag != 0:
                        branch_expression = True
                else:
                    branch_expression = (flag != 0)
                block.set_branch_expression(branch_expression)

            ins = ins + 1
        else:
            msg = "missing opcode>>>>>>>  " + op_code + "  " + self.name
            self.write_msg(msg)
            ins = ins + 1
    def get_block(self,tag,ctag):
        if ctag:
            for i, block in enumerate(self.blocks_c):
                if block.get_start_address() == tag:
                    return block
        else:
            for i, block in enumerate(self.blocks_r):
                if block.get_start_address() == tag:
                    return block
        return False
                
    def visual_graph_c(self):
        G_c = nx.Graph()
        for i, block in enumerate(self.blocks_c):
            tag = block.get_start_address()
            G_c.add_node(tag)
        for j,edge in enumerate(self.edges_c):
            for frome in edge:
                G_c.add_edge(frome,edge[frome])
        nx.draw(G_c, with_labels=True)
        plt.show()

    def visitBlock(self,tag,stack):
        visitLog = {}
        visitLog[tag] = stack.copy()
        self.visited.append(visitLog)

    def isVisited(self,tag,stack):
        tempLog = {}
        tempLog[tag] = stack.copy()
        for _,visitLog in enumerate(self.visited):
            if tempLog == visitLog:
                return True
        return False

    def visual_graph_r(self):
        G_c = nx.DiGraph()
        for i, block in enumerate(self.blocks_r):
            tag = block.get_start_address()
            G_c.add_node(tag)
        for j,edge in enumerate(self.edges_r):
            for frome in edge:
                G_c.add_edge(frome,edge[frome])
        print(self.edges_r)
        nx.draw(G_c, with_labels=True)
        # nx.draw_networkx(G_c,pos=nx.spring_layout(G_c),arrows=True)
        plt.show()

    def check(self):
        self.initDfs_graph()
        # if  self.check_pre():
        #     for i, block_r in enumerate(self.blocks_r):
        #         if not self.check_privilege(block_r):
        #             self.check_SLF(block_r)
        # else:
        #      for i, block_r in enumerate(self.blocks_r):
        #             self.check_SLF(block_r)
        self.check_HCA()
        self.check_SLF()
        self.check_UEC()
        self.check_path_condition()


    def check_inter_overflow(self,first,computed):
        try:     
            if not util.isAllReal(computed, first):
                    solver.push()
                    solver.add(UGT(first, computed))
                    if util.check_sat(solver) == sat:
                        self. = True
                    solver.pop()
        except TimeoutError:
                raise
        except Exception as e:
                self.write_msg("z3 error" + e.__str__())
                

    def get_integer_over(self):
        return self.integer_over
    
    def get_integer_under(self):
        return self.integer_under

    def check_inter_underflow(self,first,second):
        
        try:     
            if not util.isAllReal(first, second):
                solver.push()
                solver.add(UGT(second, first))
                if util.check_sat(solver) == sat:
                   self.integer_under = True
                solver.pop()
        except TimeoutError:
                raise
        except Exception as e:
                self.write_msg("z3 error" + e.__str__())

    def check_path_condition(self):
        for constraint in path_condition:   
            self.check_BID(constraint)

    # check if there is an owner = msg.sender operation in creation bytecode
    def check_pre(self):
        for i, block_c in enumerate(self.blocks_c):
            if not self.check_block_caller_storage(block_c):
                continue
            return True
        return False
    
    
    # specific check of if there is an owner = msg.sender operation in creation bytecode
    def check_block_caller_storage(self,block):
        checkUnits = block.get_checkUnits()
        for i,caller_unit in enumerate(checkUnits):
            if not caller_unit.get_unit_type() == "CALLER":
                continue
            for j,sstore_unit in enumerate(checkUnits):
                if not sstore_unit.get_unit_type() == "SSTORE":
                    continue
                if int(sstore_unit.get_sstore_value(),16) == int(caller_unit.get_caller_address(),16):
                    self.owner_key = sstore_unit.get_sstore_key()
                    self.owner_value = sstore_unit.get_sstore_value()
                    return True
        return False
    
    def get_checkunit(block,ins):
          for i,checkunit in enumerate(block.get_checkUnits()):
                if checkunit.get_unit_ins() == ins:
                    return checkunit
    # check the run block has the owner == msg.sender condition

        
    def check_SSP(self,block,SSPtag):
        potential_path = self.get_potential_path(block.get_start_address())
        if not SSPtag:
            potential_path.add(block.get_start_address())
        for k in potential_path:
            block_k = self.get_block(k,False)
            block_k_index = block_k.get_instructions()
            for i in block_k_index:
                if self.op_dict_r[i] != "SSTORE":
                    continue
                else:
                    if SSPtag:
                        self.SSP = True
                    return True
        return False
    
    def check_STP(self,block):
        potential_path = self.get_potential_path(block.get_start_address())
        for k in potential_path:
            block_k = self.get_block(k,False)
            block_k_index = block_k.get_instructions()
            for i in block_k_index:
                if self.op_dict_r[i] in ['CALL', 'CALLCODE', 'DELEGATECALL']:
                    self.STP = True
                    return True
                else:
                    continue
        return False
    
    def check_SP(self,block):
        potential_path = self.get_potential_path(block.get_start_address())
        for k in potential_path:
            block_k = self.get_block(k,False)
            block_k_index = block_k.get_instructions()
            for i in block_k_index:
                if self.op_dict_r[i] != "SELFDESTRUCT":
                    continue
                else:
                    self.SP = True
                    return True       
        return False

    def ischeck_call(self,block,cins):
        insList = block.get_instructions()
        for k, ins1 in enumerate(insList): 
            if k <=  cins :
                continue
            if self.op_dict_r[ins1] == "ISZERO":
                zeor_checkUnit = self.get_checkunit(block,ins1)
                if zeor_checkUnit.get_iszero() == "0x1":
                    return True
                else:
                    continue
        return False

    def check_TS(self):
        for i, block_r in enumerate(self.blocks_r):
            insList = block_r.get_instructions()
            for j, ins in enumerate(insList):
                op_code = self.op_dict_r[ins]
                if op_code != "CALL":
                    continue
                if not self.check_sendIns(insList,j):
                    continue
                # if not self.ischeck_call(block_r,ins):
                #     continue
                if self.check_SSP(block_r,False):
                    self.TS = True
                    return True
                else:
                    continue
        return False
    
    def check_EQ(self,expression,block):

        self.check_ORI(expression)
        self.check_SBE(expression)
        # self.check_SLF(block,expression)

    def check_ORI(self,expression):

        if self.contains_symbol(expression,"origin"):
            self.ORI = True

        
        # for i, block_r in enumerate(self.blocks_r):
        #     insList = block_r.get_instructions()
        #     for j, ins in enumerate(insList):
        #         op_code = self.op_dict_r[ins]
        #         if op_code != "ORIGIN":
        #             continue
                
        #         potential_path = self.get_potential_path(block_r.get_start_address())
        #         potential_path.add(block_r.get_start_address())
                
        #         for k in potential_path:
        #             block_k = self.get_block(k,False)
        #             block_k_index = block_k.get_instructions()
        #             for kins in block_k_index:
        #                 if  k == block_r.get_start_address() and kins <= ins:
        #                     continue
        #                 checkUnit = self.get_checkunit(block_k,kins)
        #                 if checkUnit.get_unit_type() != "EQ":
        #                     continue
        #                 left = checkUnit.get_eq_left()
        #                 right = checkUnit.get_eq_right()
        #                 if left == global_state['origin'] or right == global_state['origin']:
        #                     self.ORI = True
        #                     return
        #                 else:
        #                     continue

    def contains_symbol(self,expr,symbol_name):

        if is_app(expr) and expr.decl().kind() == Z3_OP_UNINTERPRETED:
            if expr.decl().name() == symbol_name:
                return True

        for child in expr.children():
            if self.contains_symbol(child, symbol_name):
                return True

        return False

    def check_UEC(self):

        for i, block_r in enumerate(self.blocks_r):
            insList = block_r.get_instructions()
            for j, ins in enumerate(insList):
                op_code = self.op_dict_r[ins]
                if op_code != "CALL":
                    continue
                if not self.op_dict_r[ins+1] != 'SWAP':
                    continue
                swap_str = re.search(r"\d+", self.op_dict_r[ins+1]).group(0)
                swap_num = int(swap_str)
                if not all(self.op_dict_r[ins+2+j] == 'POP' for j in range(swap_num)):
                    continue
                opcode1 = self.op_dict_r[ins + swap_num + 2]
                opcode2 = self.op_dict_r[ins + swap_num + 3]
                opcode3 = self.op_dict_r[ins + swap_num + 4]
                if opcode1 == "ISZERO" \
                    or opcode1 == "DUP" and opcode2 == "ISZERO" \
                    or opcode1 == "JUMPDEST" and opcode2 == "ISZERO" \
                    or opcode1 == "JUMPDEST" and opcode2 == "DUP" and opcode3 == "ISZERO":
                        pass
                else:
                    self.UEC = True
    
    def get_UEC(self):
        return self.UEC
    

    # def check_ORI(self):
    #     for i, block_r in enumerate(self.blocks_r):
    #         insList = block_r.get_instructions()
    #         for j, ins in enumerate(insList):
    #             op_code = self.op_dict_r[ins]
    #             if op_code != "ORIGIN":
    #                 continue
                
    #             potential_path = self.get_potential_path(block_r.get_start_address())
    #             potential_path.add(block_r.get_start_address())
                
    #             for k in potential_path:
    #                 block_k = self.get_block(k,False)
    #                 block_k_index = block_k.get_instructions()
    #                 for kins in block_k_index:
    #                     if  k == block_r.get_start_address() and kins <= ins:
    #                         continue
    #                     checkUnit = self.get_checkunit(block_k,kins)
    #                     if checkUnit.get_unit_type() != "EQ":
    #                         continue
    #                     left = checkUnit.get_eq_left()
    #                     right = checkUnit.get_eq_right()
    #                     if left == global_state['origin'] or right == global_state['origin']:
    #                         self.ORI = True
    #                         return
    #                     else:
    #                         continue


    def get_ORI(self):
        return self.ORI
    
    def check_NC(self):
        graph = Graph()

        for edge in self.edges_r:
            for frome in edge:
                graph.add_edge(frome,edge[frome])
        
        allNodes = []
        for block in self.blocks_r:
            allNodes.append(block.get_start_address())

        circle_node = graph.detect_cycle_with_topological_sort(allNodes)
        
        for index in circle_node:
            block = self.get_block(index,False)
            block_ins = block.get_instructions()
            for i in block_ins:
                if self.op_dict_r[i] != "CALL":
                    continue
                self.NC = True
    
    def get_NC(self):
        return self.NC
    
    def check_privilege(self):
        for value in store_symbolic.values():
            if  self.contains_symbol(value,"caller_address"):
                return True
        return False
    
    def check_SLF(self):

        for i, block_r in enumerate(self.blocks_r):
            eqexpressions = block_r.get_eqexpressions()
            for expression in eqexpressions:
                if self.contains_symbol(expression,"caller_address"):
                    break            
            potential_path = self.get_potential_path(block_r.get_start_address())
            for k in potential_path:
                block_k = self.get_block(k,False)
                block_k_index = block_k.get_instructions()
                for i in block_k_index:
                    if self.op_dict_r[i] != "SELFDESTRUCT":
                        continue
                    self.SLF = True

    def get_SLF(self):
        return self.SLF
            
    def check_BID(self,constraint):
        if self.contains_symbol(constraint,"blockhash") or  self.contains_symbol(constraint,"timestamp") or  self.contains_symbol(constraint,"number"):
            self.BID = True

    def get_BID(self):
        return self.BID
    
    def check_address(self,address):
            
        # 检查基本格式
        if not re.match(r'^0x[a-fA-F0-9]{40}$', address):
            return False
            
        # 使用web3.py库进行进一步校验
        if not Web3.is_address(address):
            return False
        if not Web3.is_checksum_address(address):
            return False

        return True


    def check_HCA(self):
        for i, block_c in enumerate(self.blocks_c):
            insList = block_c.get_instructions()
            for j, ins in enumerate(insList):
                op_code = self.op_dict_c[ins]
                if not op_code.startswith("PUSH"):
                    continue
                vstr = re.search(r"\d+", op_code).group(0)
                length = int(vstr)
                if length != 20:
                    continue
                address = self.value_dict_c[ins]
                if not self.check_address(address):
                    continue
                self.HCA = True
                

        for i, block_r in enumerate(self.blocks_r):
            insList = block_r.get_instructions()
            for j, ins in enumerate(insList):
                op_code = self.op_dict_r[ins]
                if not op_code.startswith("PUSH"):
                    continue
                vstr = re.search(r"\d+", op_code).group(0)
                length = int(vstr)
                if length != 20:
                    continue
                address = self.value_dict_r[ins]
                if not self.check_address(address):
                    continue
                self.HCA = True

    def get_HCA(self):
        return self.HCA


    def check_SBE(self,expression):
        
        if self.contains_symbol(expression,"selfbalance"):
            self.ORI = True
        
        #  for i, block_r in enumerate(self.blocks_r):
        #     insList = block_r.get_instructions()
        #     for j, ins in enumerate(insList):
        #         op_code = self.op_dict_r[ins]
        #         if op_code != "SELFBALANCE":
        #             continue
        #         potential_path = self.get_potential_path(block_r.get_start_address())
        #         potential_path.add(block_r.get_start_address())
        #         for k in potential_path:
        #             block_k = self.get_block(k,False)
        #             block_k_index = block_k.get_instructions()
        #             for kins in block_k_index:
        #                 if  k == block_r.get_start_address() and kins <= ins:
        #                     continue
        #                 checkUnit = self.get_checkunit(block_k,kins)
        #                 if checkUnit.get_unit_type() != "EQ":
        #                     continue
        #                 left = checkUnit.get_eq_left()
        #                 right = checkUnit.get_eq_right()
        #                 if left == global_state['balance'] or right == global_state['balance']:
        #                     self.SBE = True
        #                     return
        #                 else:
        #                     continue

    def get_SBE(self):
        return self.SBE
    

    def check_sendIns(self,insList,start):
        if start + 6 >= insList.__len__():
            return False
        pattern=["CALL","SWAP4","POP","POP","POP","POP"]
        for num in range(0,6):
            if pattern[num] != self.op_dict_r[insList[start + num]]:
                return False
        if self.op_dict_r[insList[start + 6]] == "ISZERO":
            return False
        elif self.op_dict_r[insList[start + 6]] == "POP":
            return True
        else:
            return True
        
    def check_isolate(self,block):
        if not hasattr(block,'fall_to') and block.get_jump_to().__len__() == 0:
            return True
        return False
    
    def has_edges(self,edges,anode,bnode):
        for edge in edges:
            if anode in edge and edge[anode] == bnode:
                return True
        return False

    def add_edges(self,edges,anode,bnode):
        edge_info = {}
        edge_info[anode] = bnode
        edges.append(edge_info)

    def initDfs_graph(self):
        for block in self.blocks_r:
            self.graph_dict[block.get_start_address()] = set()
            for i in self.edges_r:
                if list(i.keys())[0] == block.get_start_address():
                    self.graph_dict[block.get_start_address()].add(list(i.values())[0])

    def write_msg(self,msg):
        with open("./error.log",'a') as f:
            f.write(msg)
            f.write('\n')
            f.close()

    def write_msg1(self,msg):
        with open("./result.log",'a') as f:
            f.write(msg)
            f.write('\n')
            f.close()
    def get_edges(self):
        return self.edges_r

    def get_potential_path(self,tag):
        potential_path = set()
        s = [tag]
        while s:       
            vertex = s.pop()   
            if vertex not in potential_path:
                potential_path.add(vertex)
                s.extend(self.graph_dict[vertex] - potential_path)
        potential_path.remove(tag)

        return potential_path

    def printCFG(self):
        res = self.name + "\n" 
        er = ''.join(str(item) for item in self.edges_r)
        return res + er 

    # print check units
    def print_checkunits(self):
        print("creation checkunits >>>>>>>>")
        for i, block_c in enumerate(self.blocks_c):
            for j, check_unit_c in enumerate(block_c.get_checkUnits()):
                check_unit_c.print_data()
        print("runtime checkunits >>>>>>>>>")
        for i, block_r in enumerate(self.blocks_r):
            for j, check_unit_r in enumerate(block_r.get_checkUnits()):
                check_unit_r.print_data()
    def __del__(self):
        return
    

# test = contract("SimpleStorage")
test = contract("Donate_Eth_For_Charity")
# test = contract("Greeter_")
# test = contract("ERC20..")
# test = contract("KeeperCompatible")
# test = contract("Booking_Contract")
# test = contract("Escrow")
# test = contract("ERC721_Receiver")
# test = contract("Fundraiser")
# test = contract("Bank")
# test = contract("MyContract")
# test = contract("Ownable")
# test = contract("ERC1155")
# test = contract("Fundraiser")

# datasize = BitVec("data_size", 256)
# expression = datasize != 0
# solver.push() 
# solver.add(expression)
# if solver.check() == unsat:
#     print("1111")
# else:
#     print("22222")

# compare = BitVec("origin1", 256)
# compare1 = BitVec("origin", 256)

# express = compare1 + compare

# test.contains_symbol(express,"origin")
