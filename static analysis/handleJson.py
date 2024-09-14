import json
import os
import random
import re
import shutil

from analysis_unit import analysis_unit
from contract import contract
import statistic as excel_to_res

# Paths and Configuration
SOLC_VERSION_PATH = "solc compiler path"
BIN_PROCESS_PATH = "./process/"
RUN_PROCESS_PATH = "./process-run/"
INPUT_JSON_PATH = './completion_v3.json'
INPUT_DIR = "./input/"
OUTPUT_DIR = "./output/"
BIN_FULL_PATH = "./bin-full/"
BIN_RUN_PATH = "./bin-runtime/"
BIN_CREATION_PATH = "./bin-creation/"
OPCODES_RUNTIME_PATH = "./opcodes-runtime/"
OPCODES_CREATION_PATH = "./opcodes-creation/"
OUTPUT_AST_PATH = "./output_ast/"

# Constants for log file paths
CONTRACT_LOG_PATH = "./contract.log"
FUNCTION_LOG_PATH = "./function.log"
RECORD_LOG_PATH = "./record.log"

# Constants variable
AST_COMPACT_JSON_OPTION = " --ast-compact-json "
DEFAULT_SOLC_VERSION = "0.8.9"

# Version Tags
VERSION_TAGS = []

# Input Map
input_map = {}


def run():
    """
    Processes the JSON file to generate input and output Solidity files.
    Reads data from a JSON file, extracts relevant information, and writes it to Solidity files.
    """

    # Load data from the JSON file
    with open(INPUT_JSON_PATH, 'r', encoding='utf-8') as json_file:
        data = json.load(json_file)
        
        for key, value in data.items():
            # Extract the number from the key
            numbers = re.findall(r'\d+', key)[0]
            input_file_name = f"input_{numbers}.sol"
            output_file_name = f"output_{numbers}.sol"

            # Define full paths for input and output files
            input_file_path = os.path.join(INPUT_DIR, input_file_name)
            output_file_path = os.path.join(OUTPUT_DIR, output_file_name)

            # Write input and output data to respective files
            with open(input_file_path, "w", encoding='utf-8') as input_file, \
                 open(output_file_path, "w", encoding='utf-8') as output_file:
                input_file.write(value['input'])
                output_content = value['output'] if value['output'] else value['input']
                output_file.write(output_content)

def make_ast():
    """
    Processes Solidity files to generate ASTs using specified solc versions.
    Scans the output directory for files, checks versions, and runs the solc command to generate ASTs.
    """
    # Ensure the output directory exists
    if not os.path.exists(OUTPUT_AST_PATH):
        os.makedirs(OUTPUT_AST_PATH)

    # Walk through the output directory
    for root, _, files in os.walk(OUTPUT_DIR):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            version = get_version(file_path)

            # Check version compatibility
            if version == "mismatch":
                write_msg(f"Version mismatch for file {file_name}")
                continue

            # Extract major and minor version numbers
            numlist = version.split('.')
            try:
                major_version = int(numlist[1].strip())
                minor_version = int(numlist[2].strip())
            except IndexError:
                write_msg(f"Invalid version format for file {file_name}")
                continue

            # Skip if version is too old
            if major_version == 4 and minor_version <= 11:
                write_msg(f"Low version for file {file_name}")
                continue

            solc_cmd_path = os.path.join(SOLC_VERSION_PATH, f"solc-v{version}", "solc.exe")
            if not os.path.isfile(solc_cmd_path):
                write_msg(f"No solc version {version} found for file {file_name}")
                continue

            # Construct the command to generate AST
            command_json = f"{solc_cmd_path}{AST_COMPACT_JSON_OPTION}{file_path} -o {OUTPUT_AST_PATH}"

            # Run the command to generate AST
            if not os.path.isfile(file_path):
                write_msg(f"No Solidity file found for {file_name}")
                continue

            os.system(command_json)

            # Fallback to default solc version if AST file is not generated
            output_ast_file = os.path.join(OUTPUT_AST_PATH, f"{file_name}_json.ast")
            if not os.path.isfile(output_ast_file):
                solc_cmd_path = os.path.join(SOLC_VERSION_PATH, f"solc-v{DEFAULT_SOLC_VERSION}", "solc.exe")
                command_json = f"{solc_cmd_path}{AST_COMPACT_JSON_OPTION}{file_path} -o {OUTPUT_AST_PATH}"
                os.system(command_json)

                if not os.path.isfile(output_ast_file):
                    write_msg_compile(f"Write error for file {file_name}")
                else:
                    VERSION_TAGS.append(get_key(file_name))

def handle_input():
    """
    Processes Solidity files in the input directory to extract and log contract and function information.
    Scans each file for contract and function definitions and logs the results to corresponding files.
    """
    for root, _, files in os.walk(INPUT_DIR):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            
            # Read the content of the file
            with open(file_path, "r", encoding='utf-8') as input_file:
                sol_str = input_file.read()
                
                # Find all contract names
                contract_matches = re.findall(r'contract\s+(\w+)\s+.*{', sol_str)
                contract_matches = list(set(contract_matches))
                
                if contract_matches:
                    # Log contract information
                    contract_info = " ".join(contract_matches)
                    log_message = f"{file_name} {len(contract_matches)} {contract_info}"
                    write_log(CONTRACT_LOG_PATH, log_message)
                else:
                    # Find all function names if no contracts found
                    function_matches = re.findall(r'function\s+(\w+)\s*\(', sol_str)
                    function_matches = list(set(function_matches))
                    
                    if function_matches:
                        # Log function information
                        function_info = " ".join(function_matches)
                        log_message = f"{file_name} {len(function_matches)} {function_info}"
                        write_log(FUNCTION_LOG_PATH, log_message)
                    else:
                        # Log file if no contracts or functions found
                        write_log(RECORD_LOG_PATH, file_name)
                    

def ast_get_name_by_id(node_id, id_list):
    """
    Retrieve the name associated with a given node ID from the id_list.

    Parameters:
    - node_id: The ID of the node.
    - id_list: A dictionary mapping node names to their IDs and other information.

    Returns:
    - The name associated with the given node ID, or an empty string if not found.
    """
    for name, info in id_list.items():
        if info[0] == node_id:
            return name
    return ""


def handle_ast():
    """
    Processes AST files to update the analysis units based on contract definitions and function selectors.
    Reads AST files, extracts relevant information, and updates the global input_map with analysis results.
    """
    global input_map

    for root, _, files in os.walk(OUTPUT_AST_PATH):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            
            with open(file_path, "r", encoding='utf-8') as ast_file:
                key = get_key(file_name)
                if key not in input_map:
                    continue
                
                unit = input_map[key]
                contents = json.load(ast_file)
                id_info = contents.get("nodes", [])
                id_list = contents.get("exportedSymbols", {})

                # Process contract definitions
                for info in id_info:
                    if info.get('nodeType') == "ContractDefinition" and info.get('contractKind') == "contract":
                        unit.add_ast_contract_node(info.get('name', ''))

                # Process contracts and functions based on unit type
                if unit.get_type() == 1:
                    contracts = unit.get_contracts()
                    if len(contracts) == 1:
                        unit.add_analysis_contract(contracts[0])
                    else:
                        all_nodes_id = [id_list.get(contract, [None])[0] for contract in contracts if contract in id_list]
                        for info in id_info:
                            if info.get('nodeType') == "ContractDefinition" and info.get('contractKind') == "contract":
                                contract_name = info.get('name')
                                if contract_name in contracts:
                                    dependencies = info.get('contractDependencies', [])
                                    all_nodes_id = [node_id for node_id in all_nodes_id if node_id not in dependencies]
                        for node_id in all_nodes_id:
                            name = ast_get_name_by_id(node_id, id_list)
                            if name:
                                unit.add_analysis_contract(name)
                elif unit.get_type() == 2:
                    functions = unit.get_functions()
                    if functions:
                        for info in id_info:
                            if info.get('nodeType') == "ContractDefinition" and info.get('contractKind') == "contract":
                                for func_info in info.get('nodes', []):
                                    if func_info.get('nodeType') == "FunctionDefinition" and func_info.get('kind') == "function":
                                        function_selector = func_info.get('functionSelector')
                                        if function_selector:
                                            unit.add_function_sig(function_selector)

def initial_map():

    global input_map

    with open(CONTRACT_LOG_PATH, "r", encoding='utf-8') as contract_file: 
        while True:
            line = contract_file.readline()
            if line == '':
                break
            content = line.split()
            ckey = get_key(content[0])
            ctype = 1
            unit = analysis_unit(ckey,ctype)
            for i in range(2,content.__len__()):
                unit.add_contract(content[i])
            input_map[ckey] = unit
    with open(FUNCTION_LOG_PATH, "r", encoding='utf-8') as function_file: 
        while True:
            line = function_file.readline()
            if line == '':
                break
            content = line.split()
            fkey = get_key(content[0])
            ftype = 2
            unit = analysis_unit(fkey,ftype)
            with open("./output/output_" + fkey + ".sol", "r", encoding='utf-8') as input_file:
                solstr = input_file.read();
                cmatches = re.findall(r'contract\s+(\w+)\s*{', solstr)
                cmatches = list(set(cmatches))
                if cmatches.__len__() == 0:
                    write_msg_compile("meaning1 less sol " + fkey)
                    continue
                else:
                    unit.add_analysis_contract(cmatches[0])
            for i in range(2,content.__len__()):
                unit.add_function(content[i])
            input_map[fkey] = unit
    with open(RECORD_LOG_PATH, "r", encoding='utf-8') as record_file: 
        while True:
            line = record_file.readline()
            if line == '':
                break
            content = line.split()
            rkey = get_key(content[0])
            rtype = 3
            unit = analysis_unit(rkey,rtype)
            with open("./output/output_" + rkey + ".sol", "r", encoding='utf-8') as input_file:
                solstr = input_file.read();
                cmatches = re.findall(r'contract\s+(\w+)\s*{', solstr)
                cmatches = list(set(cmatches))
                if cmatches.__len__() == 0:
                    write_msg_compile("meaning2 less sol " + rkey)
                    continue
                else:
                    for item in cmatches:
                        unit.add_analysis_contract(item)
            input_map[rkey] = unit

        

def get_key(str):
    pattern = re.compile(r'\d+')
    matches = pattern.findall(str)
    return matches[0]


def get_version(path):
    with open(path,'r',encoding='utf-8') as disasm_file:
        while True:
            line = disasm_file.readline()
            if line == '':
                break
            pattern = re.compile(r'pragma solidity')
            if re.search(pattern, line):
                detail_pattern = r"\^?(\d+\.\d+\.\d+)"
                match = re.search(detail_pattern, line)
                if match:
                    return match.group(1).strip()
                else:
                    detail_pattern = r"\^?(\d+\.\d+)"
                    match = re.search(detail_pattern, line)
                    if match:
                        return match.group(1).strip() + ".1"
                break
            else:
                continue
    return "mismatch"



def compileLatter(index,fileName,contractName,solcCmd,unit):
    
    """
    Handles the compilation of a contract, including moving files, extracting creation code, and disassembling.
    """
    
    fileFullName = contractName + ".bin"
    fileRunName = contractName + ".bin-runtime"
    fileCreationName = contractName + ".bin-creation"
    opcodesRunName = contractName + ".opcodes-runtime"
    opcodesCreationName = contractName + ".opcodes-creation"
    originFullName = BIN_PROCESS_PATH + fileFullName
    originRunName = RUN_PROCESS_PATH + fileRunName

    if not os.path.isfile(originFullName):
        write_msg("compile full error " + contractName)
        return False

    contractName = contractName + "_" + unit.get_index()
    fileFullName = contractName + ".bin"
    fileRunName = contractName + ".bin-runtime"
    fileCreationName = contractName + ".bin-creation"
    opcodesRunName = contractName + ".opcodes-runtime"
    opcodesCreationName = contractName + ".opcodes-creation"

    while os.path.isfile(BIN_FULL_PATH + fileFullName):
        random_number = random.randint(1,10)
        contractName = contractName + "_" + str(random_number)
        fileFullName = contractName + ".bin"
        fileRunName = contractName + ".bin-runtime"
        fileCreationName = contractName + ".bin-creation"
        opcodesRunName = contractName + ".opcodes-runtime"
        opcodesCreationName = contractName + ".opcodes-creation"

    shutil.move(originFullName,BIN_FULL_PATH + fileFullName)


    clear_run_process()

    # Recompile runtime binary
    command_run = f"{solcCmd} --bin-runtime {OUTPUT_DIR}{fileName} -o {RUN_PROCESS_PATH}"
    os.system(command_run)

    # Check if runtime binary exists
    if not os.path.isfile(originRunName):
        write_msg("compile run error" + command_run + " " + originRunName)
        return False

    shutil.move(originRunName,BIN_RUN_PATH + fileRunName)
    

    # Read full and runtime binaries
    with open(os.path.join(BIN_FULL_PATH, fileFullName), 'r', encoding='utf-8') as f:
        str_full = f.read()
    with open(os.path.join(BIN_RUN_PATH, fileRunName), 'r', encoding='utf-8') as f:
        str_run = f.read()

    # Extract creation code
    creation_code = str_full[:-len(str_run)]
    with open(os.path.join(BIN_CREATION_PATH, fileCreationName), 'w', encoding='utf-8') as f:
        f.write(creation_code)

    # Disassemble runtime and creation binaries
    if not disassemble_evm(BIN_RUN_PATH, OPCODES_RUNTIME_PATH, fileRunName, opcodesRunName):
        return False
    if not disassemble_evm(BIN_CREATION_PATH, OPCODES_CREATION_PATH, fileCreationName, opcodesCreationName):
        return False


    # Add analysis result to unit
    contract_analysis = contract(contractName, index, unit.get_function_sigs())
    unit.add_contract_result(contract_analysis)

    return True

def disassemble_evm(bin_path, opcode_path, bin_name,opcodes_name):
    """
    Disassembles the binary file using evm and writes to the opcode file.
    """
    command = f"evm disasm {bin_path}{bin_name} > {opcode_path}{opcodes_name}"
    os.system(command)
    
    if not os.path.isfile(f"{opcode_path}{opcodes_name}"):
        write_msg(f"Opcode disassembly error: {command}")
        return False
    return True

def compile_contract(index, fileName, contractName, solcCmd, unit):
    """
    Compiles the contract using the provided Solidity compiler command.
    If the compilation is successful, marks the unit as passed.
    """
    if compileLatter(index, fileName, contractName, solcCmd, unit):
        unit.mark_passed_compilation()
        return True
    return False

def process_contracts(index, fileName, contractName, solcCmd, unit):
    """
    Processes and compiles all contracts in the unit. 
    Returns True if at least one contract was successfully compiled.
    """
    compiled = False
    ast_contracts = unit.get_ast_contract_nodes()

    if contractName in ast_contracts:
        compiled = compile_contract(index, fileName, contractName, solcCmd, unit)
    elif ast_contracts:
        for ast_contract in ast_contracts:
            if compile_contract(index, fileName, ast_contract, solcCmd, unit):
                compiled = True
    return compiled

def compileInputMap():
    global input_map

    for index, unit in input_map.items():
        print(f"Now compiling index: {index}")
        
        fileName = f"output_{index}.sol"
        jsonName = f"output_{index}.sol_json.ast"

        if not os.path.isfile(f"./output_ast/{jsonName}"):
            write_msg_compile(f"compile error>>>>>> {index}")
            continue

        analysis_contracts = unit.get_analysis_contracts()
        version = get_version(OUTPUT_DIR + fileName)

        # Override version if necessary
        if index in VERSION_TAGS:
            version = DEFAULT_SOLC_VERSION

        # Clear previous compilation processes
        clear_process()

        solcCmd = f"{SOLC_VERSION_PATH}solc-v{version}\\solc.exe"
        command_full = f"{solcCmd} --bin {OUTPUT_DIR}{fileName} -o {BIN_PROCESS_PATH}"
        os.system(command_full)

        # Compile each contract in the analysis_contracts list
        compiled = False
        for contractName in analysis_contracts:
            if process_contracts(index, fileName, contractName, solcCmd, unit):
                compiled = True

        # Check if the unit passed compilation
        if not compiled:
            write_msg_compile(f"meaningless sol>>>>>> {index}")


def ensure_directory_exists(dir_path):
    """
    Ensure that a directory exists by deleting it if it already exists and then recreating it.
    
    Parameters:
    - dir_path: Path to the directory to ensure.
    """
    if os.path.exists(dir_path):
        shutil.rmtree(dir_path)
    os.makedirs(dir_path)


def clean_compile_files():
    """
    Clean and recreate necessary directories for compilation.
    """
    ensure_directory_exists(BIN_FULL_PATH)
    ensure_directory_exists(BIN_CREATION_PATH)
    ensure_directory_exists(BIN_RUN_PATH)
    ensure_directory_exists(OPCODES_RUNTIME_PATH)
    ensure_directory_exists(OPCODES_CREATION_PATH)


def write_msg_compile(msg):
    with open("./nocompile.log",'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()  
    

def cleanLog():
    with open("./nocompile.log",'w') as f:
        f.flush()
        f.close()
    with open("./contract.log",'w') as f:
        f.flush()
        f.close()
    with open("./function.log",'w') as f:
        f.flush()
        f.close()
    with open("./record.log",'w') as f:
        f.flush()
        f.close()

def write_msg(msg):
    with open("./error.log",'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()


def write_log(path,msg):
     with open(path,'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()

def write_statics(path,msg):
    with open(path,'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()

def write_res(msg):
    with open("./result.log",'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()

def clear_process():
    if os.path.exists("./process/"):
        shutil.rmtree("./process/")
    os.mkdir("./process/")

def clear_run_process():
    if os.path.exists("./process-run/"):
        shutil.rmtree("./process-run/")
    os.mkdir("./process-run/")
    
def clearAll():
    if os.path.exists("./output/"):
        shutil.rmtree("./output/")
    os.mkdir("./output/")

    if os.path.exists("./input/"):
        shutil.rmtree("./input/")
    os.mkdir("./input/")
    if os.path.exists("./output_ast/"):
        shutil.rmtree("./output_ast/")
    os.mkdir("./output_ast/")

    cleanLog()

def main():

    global input_map

    clearAll() 
   
    run()
    
    make_ast()
    
    handle_input()
    
    clean_compile_files()
    
    initial_map()
    
    handle_ast()
    
    compileInputMap()
    
    excel_to_res.read_label(input_map)

main()