import json
import re
import os
import shutil

from z3 import *
import six


# with open("./input/input_43.sol", "r", encoding='utf-8') as input_file:
#     solstr = input_file.read();
#     matches = re.findall(r'contract\s+(\w+)\s+.*{', solstr)
#     for match in matches:
#         print(match)
    # matches = re.findall(r'function\s+(\w+)\s*\(', solstr)
    # print(matches.__len__())
    # for match in matches:
    #     print(match)

# with open("./input/input_43.sol", "r", encoding='utf-8') as f:
#         contents = json.load(f)
#         idInfo = contents["nodes"]
#         for contract in unit.getContract():
#             for (index, info) in enumerate(idInfo):
#                 if info['nodeType'] != "ContractDefinition":
#                     continue
#                 if info['name'] != contract:
#                     continue
#                 if info['contractDependencies'].__len__() == 0:
#                     unit.addAnalysisContract(contract)
#                 else:
#                     continue

# for i in range(8):
#      print(i)


# def normalize_cycle(cycle):
#     """ Rotate the cycle to start with the smallest element for uniqueness. """
#     min_index = cycle.index(min(cycle))
#     return cycle[min_index:] + cycle[:min_index]

# def find_unique_cycles(graph):
#     def dfs(node, parent, visited, graph, path, cycles):
#         visited[node] = True
#         path.append(node)

#         for neighbor in graph[node]:
#             if not visited[neighbor]:
#                 dfs(neighbor, node, visited, graph, path, cycles)
#             elif neighbor != parent and neighbor in path:
#                 # Found a cycle, normalize and add it if it's not a duplicate
#                 cycle_start = path.index(neighbor)
#                 cycle = normalize_cycle(path[cycle_start:])
#                 if cycle not in cycles:
#                     cycles.add(tuple(cycle))  # Adding tuple for hashability

#         path.pop()
#         visited[node] = False  # Backtrack

#     visited = [False] * len(graph)
#     cycles = set()
#     for node in range(len(graph)):
#         if not visited[node]:
#             dfs(node, -1, visited, graph, [], cycles)
#     return [list(cycle) for cycle in cycles]

# # Example usage
# graph = {
#     0: [1, 2],
#     1: [0, 2, 3],
#     2: [0, 1, 3],
#     3: [1, 2]
# }

# unique_cycles = find_unique_cycles(graph)
# unique_cycles

sat = CheckSatResult(Z3_L_TRUE)
unsat = CheckSatResult(Z3_L_FALSE)
unknown = CheckSatResult(Z3_L_UNDEF)


x = BitVec('x', 4)
y = BitVec('y', 4)

# 创建路径条件：两个位向量相加等于8
path_condition = x + y == 8

# 创建求解器
solver = Solver()

# 获取解

solver.push()  # SET A BOUNDARY FOR SOLVER
solver.add(path_condition)

# if solver.check() == sat:
#     print("nmsl")

def isSymbolic(value):
    return not isinstance(value, six.integer_types)

def isReal(value):
    return isinstance(value, six.integer_types)

if isSymbolic(x):
    print("wsnd")