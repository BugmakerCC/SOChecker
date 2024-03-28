import re
from web3 import Web3
import networkx as nx
import matplotlib.pyplot as plt
import json

from z3 import *

from baseBlock import BasicBlock
from graph import Graph


import utils as util
from generator import *

sat = CheckSatResult(Z3_L_TRUE)
unsat = CheckSatResult(Z3_L_FALSE)
unknown = CheckSatResult(Z3_L_UNDEF)

max_depth = 300
                
creation_path = "./opcodes-creation/"

creation_postfix = ".opcodes-creation"

solfile_path = "./output/"

run_path = "./opcodes-runtime/"

run_postfix = ".opcodes-runtime"

global solver
solver = Solver()

global gen
gen = Generator()


set_option(timeout=2500)

UNSIGNED_BOUND_NUMBER = 2**256 - 1
CONSTANT_ONES_159 = BitVecVal((1 << 160) - 1, 256)

MEM_SIZE = 2000

loopLimit = 10



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


class contract:

    def __init__(self, name, index, sig):

        self.name = name

        self.index = index

        self.sig = sig

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
        
        self.graph_dict_reverse = {}
            
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

        self.visitedEdges = {}

        self.owner_key = -1

        self.owner_value = ""

        self.UEC = False

        self.ORI = False

        self.SLF = False

        self.BID = False

        self.HCA = False

        self.SBE = False

        self.DOS = False

        self.RAD = False

        self.TOD = False

        self.REC = False

        self.SAA = False
        
        self.overflow = False
        
        self.integer_over = False

        self.integer_under = False

        self.depth = 0 
        
        self.process()

        self.check()


    def clearBlock_msg(self):
        
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
        c_path = creation_path + self.name + creation_postfix
        r_path = run_path + self.name + run_postfix
        self.construct_cfg(c_path,self.op_dict_c,self.value_dict_c,self.blocks_c,self.edges_c)
        self.symbolic_exec_block(0,True,self.stack,self.op_dict_c,self.value_dict_c,self.edges_c,self.money_flow,0)
        self.clearBlock_msg()
        self.construct_cfg(r_path,self.op_dict_r,self.value_dict_r,self.blocks_r,self.edges_r)
        self.symbolic_exec_block(0,False,self.stack,self.op_dict_r,self.value_dict_r,self.edges_r,self.money_flow,0)

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
                opcode = str_list[1].strip()

                if opcode == "Missing":
                    opcode = "INVALID"
                if opcode == "KECCAK256":
                    opcode = "SHA3"
                if opcode == "opcode":
                    opcode = "INVALID"

                if pc == 1081:
                    print("")

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
                    if block.get_block_type() != "unconditional" and block.get_block_type() != "terminal":
                        interval = 1
                        if op_dict[block.get_end_address()].startswith("PUSH"):
                            vstr = re.search(r"\d+", op_dict[block.get_end_address()]).group(0)
                            num = int(vstr)
                            interval = 1 + num
                        if fall_block.get_start_address() == block.get_end_address() + interval:
                            block.set_fall_to(fall_block.get_start_address())
                            edge_info = {}
                            edge_info[block.get_start_address()] = fall_block.get_start_address()
                            edges.append(edge_info)

    def symbolic_exec_block(self,tag,ctag,stack,op_dict,value_dict,edges,money_flow,preblock):
        
        global solver
        
        self.depth = self.depth + 1
        if (self.depth > max_depth):
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

        if self.visitedEdges[accessKey] > loopLimit:
            return

        for i,ins in enumerate(block.get_instructions()):
            self.symbolic_exec_ins(block,ins,stack,op_dict,value_dict,edges,ctag,money_flow)

        if money_flow not in self.money_flow_path:
            self.money_flow_path.append(money_flow)
        
        if tag == 882:
            print("")

        if block.get_block_type() == "terminal" or self.depth > max_depth:
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
                if solver.check() == unsat:
                    self.write_msg("INFEASIBLE PATH DETECTED")
                elif solver.check() == sat:
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
                if solver.check() == unsat:
                    self.write_msg("INFEASIBLE PATH DETECTED")
                elif solver.check() == sat:
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

        op_code = op_dict[ins]
        if op_code.startswith("PUSH"):
            if value_dict.__contains__(ins):
                if self.is_valid_function_siganiture(value_dict[ins]):
                    if value_dict[ins] in self.sig:
                        pushed_value = int(value_dict[ins], 16)
                    else:
                        new_var_name = gen.gen_function_signature()
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
                    if util.isReal(first) and first == 0:
                        block.add_eqexpression(second)
                    if util.isReal(second) and second == 0:
                        block.add_eqexpression(first)
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
                if util.isReal(first) and util.isSymbolic(second):
                    first = BitVecVal(first, 256)
                    computed = first - second
                elif util.isSymbolic(first) and util.isReal(second):
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
                        check_revert = any([True for instruction in jblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                    if not check_revert and hasattr(block,'fall_to'): 
                        fall_to = block.get_fall_to()
                        fblock = self.get_block(fall_to,ctag)
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
                if util.isReal(first) and util.isSymbolic(second):
                    first = BitVecVal(first, 256)
                    computed = first + second
                elif util.isSymbolic(first) and util.isReal(second):
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
                        check_revert = any([True for instruction in jblock.get_instructions() if op_dict[instruction].startswith('REVERT')])
                    if not check_revert and hasattr(block,'fall_to'): 
                        fall_to = block.get_fall_to()
                        fblock = self.get_block(fall_to,ctag)
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
                    computed = LShR(value,shift)
                elif util.isSymbolic(shift) and util.isReal(value):
                    value = BitVecVal(value, 256)
                    computed = LShR(value,shift)
                elif util.isAllReal(shift,value):
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
                    self.check_BID(first)
                    self.check_BID(second)
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
                    self.check_BID(first)
                    self.check_BID(second)
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
                    self.check_BID(second)
                    self.check_BID(first)
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
                    block.add_iszeroexpression(computed)
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
                    self.check_BID(first)
                    self.check_BID(second)
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
                if util.isReal(stored_address):
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
                if util.isReal(stored_address):
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
                ins = ins + 1
            else:
                raise ValueError('STACK underflow')
            
        elif op_code == "MLOAD":
            if len(stack) > 0:
                stored_address = stack.pop(0)
                if util.isReal(stored_address):
                    flag,info = self.load_mem_info(stored_address,stored_address + 31)
                    if not flag:
                        var_name =  gen.gen_arbitrary_MSTORE_var()
                        new_var = BitVec(var_name, 256)
                        stack.insert(0,new_var)
                    else:
                        stack.insert(0,info["value"])
                else:
                    if not str(stored_address) in self.mem_symbolic:
                        var_name =  gen.gen_arbitrary_MSTORE_var()
                        new_var = BitVec(var_name, 256)
                        self.mem_symbolic[str(stored_address)] = new_var
                    stack.insert(0, self.mem_symbolic[str(stored_address)])
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
                recipient = stack.pop(0)
                if util.isSymbolic(recipient):
                    recipient = simplify(recipient)
                    money_flow.append(str(recipient),"remain")

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
                stored_address = stack.pop(0)
                stored_value = stack.pop(0)
                if util.isReal(stored_address):
                    self.store_real[stored_address] = stored_value
                else:
                    self.store_symbolic[str(stored_address)] = stored_value
                    if util.isSymbolic(stored_value):
                        self.store_map[ins] = stored_value
            else:
                raise ValueError('STACK underflow')
        elif op_code == "SLOAD":
            if len(stack) > 0:
                position = stack.pop(0)
                if util.isReal(position) and position in self.store_real:
                    value = self.store_real[position]
                    stack.insert(0, value)
                else:
                    if str(position) in self.store_symbolic:
                        value = self.store_symbolic[str(position)]
                        stack.insert(0, value)
                    else:
                        if is_expr(position):
                            position = simplify(position)
                        new_var_name = gen.gen_owner_store_var(position,"storevalue")
                        new_var = BitVec(new_var_name, 256)
                        stack.insert(0,new_var)
                        if util.isReal(position):
                            self.store_real[position] = new_var
                        else:
                            self.store_symbolic[str(position)] = new_var
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

                if util.isSymbolic(recipient):
                    recipient = simplify(recipient)
                
                self.money_flow_path.append((str(recipient),str(transfer_amount)))

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
            if util.isAllReal(offset,size):
                flag,valueList = self.load_size_mem_info(offset,offset+size-1)
                if flag:
                    self.check_Bad_Randomness(valueList)
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
    
    def add_mem_info(self,meminfo):
        new_mem = []
        for info in self.mem_real:
            if not (meminfo["start"] <= info["end"] and meminfo["end"] >= info["start"]):
               new_mem.append(info)
        new_mem.append(meminfo)
        self.mem_real.clear()
        self.mem_real = new_mem

    def load_mem_info(self,start,end):
        for info in self.mem_real:
            if start == info["start"] and end == info["end"]:
                return True,info
        return False,{}

    def load_size_mem_info(self,start,end):
        res = []
        flag = False
        for info in self.mem_real:
            if info["start"] >= start and info["end"] <= end:
                res.append(info)
                flag = True
        return flag,res
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
        plt.show()

    def check(self):
        self.initDfs_graph()
        self.initDfs_graph_reverse()
        self.check_SAA()
        self.check_SLF()
        self.check_UEC()
        self.check_DOS()
        self.check_path_condition()
        self.check_REC()
        self.check_TOD()


    def check_inter_overflow(self,first,computed,second,block):
        if not self.pre_check_IOF(solfile_path+"output_" + str(self.index) +".sol"):
            return

        if util.isReal(first) or util.isReal(second):
            return

        dataloadFlag = False

        if util.isSymbolic(first):
            if first.sexpr() in self.call_data_map:
                dataloadFlag = True
            if 'sha_res' in str(first).replace(' ', ''):
                return
            if str(first).isdigit():
                return
            
        if util.isSymbolic(second):
            if second.sexpr() in self.call_data_map:
                dataloadFlag = True
            if 'sha_res' in str(second).replace(' ', ''):
                return
            if str(second).isdigit():
                return
        if not dataloadFlag:
            return

        newsolver = Solver()
        newsolver.add(UGT(first, computed))

        if self.check_need_addconstraint():
            for constraint in block.get_path_condition():
                pathVar = str(constraint).replace(' ', '')
                if str(first).replace(' ', '') in pathVar and str(second).replace(' ', '') in pathVar:
                    newsolver.add(constraint)
                    break
            
        if util.check_sat(newsolver) == sat:
            self.integer_over = True
        del newsolver

    def get_integer_over(self):
        return self.integer_over
    
    def get_integer_under(self):
        return self.integer_under
    
    def check_need_addconstraint(self):
        jsonFileName = "./output_ast/output_" + str(self.index) + ".sol_json.ast"
        with open(jsonFileName, "r", encoding='utf-8') as ast_file:
                contents = json.load(ast_file)
                idInfo = contents["nodes"]
                idList = contents["exportedSymbols"]

                for info in idInfo:
                    if info['nodeType'] != "ContractDefinition":
                        continue
                    if info['contractKind'] != "library":
                        continue
                    if not "math" in str(info['name']).lower():
                        continue
                    return True
        return False

    def check_inter_underflow(self,first,second,block):

        if not self.pre_check_IUF(solfile_path+"output_" + str(self.index) +".sol"):
            return

        if util.isReal(first) or util.isReal(second):
            return

        
        dataloadFlag = False

        if util.isSymbolic(first):
            if first.sexpr() in self.call_data_map:
                dataloadFlag = True
            if 'sha_res' in str(first).replace(' ', ''):
                return
            if str(first).isdigit():
                return
            
        if util.isSymbolic(second):
            if second.sexpr() in self.call_data_map:
                dataloadFlag = True
            if 'sha_res' in str(second).replace(' ', ''):
                return
            if str(second).isdigit():
                return
        if not dataloadFlag:
            return
        
        newsolver = Solver()
        newsolver.add(UGT(second, first))

        if self.check_need_addconstraint():                            
            for constraint in block.get_path_condition():
                pathVar = str(constraint).replace(' ', '')
                if str(first).replace(' ', '') in pathVar and str(second).replace(' ', '') in pathVar:
                    newsolver.add(constraint)
                    break
        
        if util.check_sat(newsolver) == sat:
            self.integer_under = True
        del newsolver


    def check_path_condition(self):
        for constraint in self.path_condition:   
            self.check_BID(constraint)

    
    def check_EQ(self,expression,block):

        self.check_ORI(expression)
        self.check_SBE(expression)

    def check_ORI(self,expression):

        if self.contains_symbol(expression,"origin"):
            self.ORI = True

    def contains_symbol(self,expr,symbol_name):

        if is_app(expr) and expr.decl().kind() == Z3_OP_UNINTERPRETED:
            if expr.decl().name() == symbol_name:
                return True
        a = expr.children()
        for child in expr.children():
            if self.contains_symbol(child, symbol_name):
                return True

        return False

    def check_UEC(self):

        if not self.pre_check_UEC(solfile_path+"output_" + str(self.index) +".sol"):
            return

        for i, block_r in enumerate(self.blocks_r):
            insList = block_r.get_instructions()
            for j, ins in enumerate(insList):
                op_code = self.op_dict_r[ins]
                if op_code != "CALL":
                    continue
                flag = False
                potential_path = self.get_potential_path(block_r.get_start_address())
                potential_path.add(block_r.get_start_address())
                for k in potential_path:
                    block_k = self.get_block(k,False)

                    for constraint in block_k.get_path_condition():
                        if util.isSymbolic(constraint) and self.contains_symbol(constraint,"call_res"):
                            flag = True
                            break
                    if not hasattr(block_k,'get_iszeroexpressions'):
                        return
                    iszeroexpressions = block_k.get_iszeroexpressions()
                    for expression in iszeroexpressions:
                        if self.contains_symbol(expression,"call_res") :
                            flag = True
                            break 
    
                if not flag:
                    self.UEC = True
    
    def get_UEC(self):
        return self.UEC
    
    def get_TOD(self):
        return self.TOD

    def get_REC(self):
        return self.REC


    def get_ORI(self):
        return self.ORI
    
        
    def pre_check_DOS(self,path):
        
        flagLoop = False
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if "for(" in line or "for (" in line or "while" in line:
                    flagLoop = True

        flagCall = False
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if ".transfer" in line:
                    flagCall = True
        
        return flagLoop and flagCall
    

    def find_cycles(graph):
        visited = set()
        rec_stack = set()
        cycles = []

        def dfs(node, cycle):
            if node in rec_stack:
                cycles.append(cycle[rec_stack.index(node):])
                return

            if node in visited:
                return

            visited.add(node)
            rec_stack.add(node)
            cycle.append(node)

            for neighbor in graph.get(node, []):
                dfs(neighbor, cycle)

            rec_stack.remove(node)
            cycle.pop()

        for node in graph:
            dfs(node, [])

        return cycles
    
    def check_DOS(self):

        if not self.pre_check_DOS(solfile_path+"output_" + str(self.index) +".sol"):
            return
        
        graph = Graph()

        for edge in self.edges_r:
            for frome in edge:
                graph.add_edge(frome,edge[frome])
        
        allNodes = []
        for block in self.blocks_r:
            allNodes.append(block.get_start_address())

        circle_node = graph.detect_cycle_with_topological_sort(allNodes)
        
        if circle_node.__len__() <= 1:
            return

        cycles = graph.find_cycles()

        for circle in  cycles:
            for index in circle:
                block = self.get_block(index,False)
                block_ins = block.get_instructions()
                for i in block_ins:
                    if self.op_dict_r[i] != "CALL":
                        continue
                    self.DOS = True
    
    def get_DOS(self):
        return self.DOS
    
    def check_privilege(self):
        for value in self.store_symbolic.values():
            if  self.contains_symbol(value,"caller_address"):
                return True
        return False
    

    def check_REC(self):

        
        if not self.pre_check_REC(solfile_path+"output_" + str(self.index) +".sol"):
            return

        for i, block_r in enumerate(self.blocks_r):
            insList = block_r.get_instructions()
            for j, ins in enumerate(insList):
                op_code = self.op_dict_r[ins]
                if op_code != "CALL":
                    continue
                for constraint in block_r.get_path_condition():
                    if util.isSymbolic(constraint) and self.contains_symbol(constraint,"caller_address"):
                        return
                potential_path = self.get_potential_path(block_r.get_start_address())
                for k in potential_path:
                    block_k = self.get_block(k,False)
                    block_k_index = block_k.get_instructions()
                    for kins in block_k_index:
                        if self.op_dict_r[kins] == "SSTORE":
                            if kins in self.store_map:
                                storeVar = str(self.store_map[kins]).replace(' ', '')
                                if not "Ia_store" in storeVar:
                                        continue
                                for constraint in self.path_condition:
                                    pathVar = str(constraint).replace(' ', '')
                                    if storeVar in pathVar:
                                        self.REC = True
                                        return

            

    def check_SLF(self):

        if not self.pre_check_SLF(solfile_path+"output_" + str(self.index) +".sol"):
            return
        
        for i, block_r in enumerate(self.blocks_r):
            r_instructions = block_r.get_instructions()
            for j in r_instructions:
                if self.op_dict_r[j] != "SELFDESTRUCT":
                    continue
                flag = False

                for constraint in block_r.get_path_condition():
                    if util.isSymbolic(constraint) and self.contains_symbol(constraint,"caller_address"):
                        flag = True

                potential_path_reverse = self.get_potential_path_reverse(block_r.get_start_address())
                for k in potential_path_reverse:
                    block_k = self.get_block(k,False)
                    eqexpressions = block_k.get_eqexpressions()
                    for expression in eqexpressions:
                        if self.contains_symbol(expression,"caller_address"):
                            flag = True
                            break            
                if not flag:
                    self.SLF = True

    def get_SLF(self):
        return self.SLF
            
    def check_BID(self,constraint):
        if not is_expr(constraint):
            return
        if self.contains_symbol(constraint,"blockhash") or  self.contains_symbol(constraint,"timestamp") or  self.contains_symbol(constraint,"number"):
            self.BID = True

    def check_Bad_Randomness(self,infoList):

        if not self.pre_check_RAD(solfile_path+"output_" + str(self.index) +".sol"):
            return
        
        for info in infoList:
            if util.isSymbolic(info["value"]):
                self.check_BID(info["value"])
                if self.contains_symbol(info["value"],"number") or self.contains_symbol(info["value"],"difficulty") or self.contains_symbol(info["value"],"timestamp"):
                    self.RAD = True
    
    def get_RAD(self):
        return self.RAD
    def get_BID(self):
        return self.BID
    
    def check_address(self,address):
            
        if not re.match(r'^0x[a-fA-F0-9]{40}$', address):
            return False
            
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
    

    def check_SAA(self):   

        with open(solfile_path+"output_" + str(self.index) +".sol",'r',encoding='utf-8') as file:
            content = file.read()
        matches = re.findall(r'^0x[0-9a-fA-F]{1,39}$', content)

        if matches:
            self.SAA = True

    def get_SAA(self):
        return self.SAA

    def check_TOD(self):
        i = 0
        for flow in self.money_flow_path:
            i += 1
            if len(flow) == 1:
                continue 
        for j in range(i, len(self.money_flow_path)):
            jflow = self.money_flow_path[j]
            if len(jflow) == 1:
                continue
            if util.is_diff(flow, jflow):
                self.TOD = True
                break

    def check_SBE(self,expression):
        
        if self.contains_symbol(expression,"selfbalance"):
            self.ORI = True

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

    def initDfs_graph_reverse(self):
        for block in self.blocks_r:
            self.graph_dict_reverse[block.get_start_address()] = set()
            for i in self.edges_r:
                if list(i.values())[0] == block.get_start_address():
                    self.graph_dict_reverse[block.get_start_address()].add(list(i.keys())[0])

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
    
    def pre_check_UEC(self,path):
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if ".call(" in line or ".send(" in line or ".call{" in line:
                    return True
        return False

    def pre_check_REC(self,path):
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if ".call(" in line or ".send(" in line or ".call{" in line or ".transfer(" in line:
                    return True
        return False
    
    def pre_check_RAD(self,path):
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if "keccak256" in line:
                    return True
        return False
    
    def pre_check_IOF(self,path):
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if re.search(r'(?<!\+)\+(?!\+)', line):
                    return True
        return False

    def pre_check_IUF(self,path):
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if re.search(r'(?<!\-)\-(?!\-)', line):
                    return True
        return False
    
    def pre_check_SLF(self,path):
        with open(path,'r',encoding='utf-8') as file:
            for line in file:
                if "selfdestruct" in line:
                    return True
        return False

    def get_potential_path(self,tag):
        potential_path = set()
        s = [tag]
        while s:       
            vertex = s.pop()   
            if vertex not in potential_path:
                potential_path.add(vertex)
                if vertex in self.graph_dict:
                    s.extend(self.graph_dict[vertex] - potential_path)
        potential_path.remove(tag)

        return potential_path
    
    def get_potential_path_reverse(self,tag):
        potential_path = set()
        s = [tag]
        while s:       
            vertex = s.pop()   
            if vertex not in potential_path:
                potential_path.add(vertex)
                s.extend(self.graph_dict_reverse[vertex] - potential_path)
        potential_path.remove(tag)

        return potential_path
    
    def get_potential_path_reverse_part(self,tag):

        graph_dict_reverse = {}
        for block in self.blocks_r:
            graph_dict_reverse[block.get_start_address()] = set()
            for i in self.edges_r:
                if list(i.values())[0] == block.get_start_address():
                    graph_dict_reverse[block.get_start_address()].add(list(i.keys())[0])
        
        potential_path = set()
        s = [tag]
        while s:       
            vertex = s.pop()   
            if vertex not in potential_path:
                potential_path.add(vertex)
                s.extend(graph_dict_reverse[vertex] - potential_path)
        potential_path.remove(tag)

        return potential_path
    
    def is_valid_function_siganiture(self,s):
        try:
            int(s, 16)
        except ValueError:
            return False

        return len(s) == 10


    def printCFG(self):
        res = self.name + "\n" 
        er = ''.join(str(item) for item in self.edges_r)
        return res + er 

    def __del__(self):
        return

