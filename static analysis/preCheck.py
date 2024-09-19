import re
import json

def _check_patterns_in_file(path, patterns):
    """
    Generic method to check if any of the patterns exist in the given file.
    Returns True if any pattern is found, otherwise False.
    """
    with open(path, 'r', encoding='utf-8') as file:
        for line in file:
            if any(re.search(pattern, line) for pattern in patterns):
                return True
    return False

def pre_check_DOS(path):
    """
    Pre-check for Denial of Service (DOS) vulnerability.
    Detects the presence of loops and `.transfer` calls.
    """
    flag_loop = _check_patterns_in_file(path, [r"for\s?\(", r"while"])
    flag_call = _check_patterns_in_file(path, [r"\.transfer"])
    return flag_loop and flag_call

def pre_check_UEC(path):
    """
    Pre-check for Unchecked External Calls (UEC).
    Detects `.call`, `.send`, or `.call{`.
    """
    return _check_patterns_in_file(path, [r"\.call\(", r"\.send\(", r"\.call\{"])

def pre_check_REC(path):
    """
    Pre-check for Reentrancy vulnerability (REC).
    Detects `.call`, `.send`, or `.transfer`.
    """
    return _check_patterns_in_file(path, [r"\.call\(", r"\.send\(", r"\.call\{", r"\.transfer\("])

def pre_check_RAD(path):
    """
    Pre-check for Randomness Attack Detection (RAD).
    Detects the use of `keccak256`.
    """
    return _check_patterns_in_file(path, [r"keccak256"])

def pre_check_IOF(path):
    """
    Pre-check for Integer Overflow (IOF).
    Detects `+` operations excluding `++`.
    """
    return _check_patterns_in_file(path, [r"(?<!\+)\+(?!\+)"])

def pre_check_IUF(path):
    """
    Pre-check for Integer Underflow (IUF).
    Detects `-` operations excluding `--`.
    """
    return _check_patterns_in_file(path, [r"(?<!\-)\-(?!\-)"])

def pre_check_SLF(path):
    """
    Pre-check for Self-Destruct (SLF).
    Detects the use of `selfdestruct`.
    """
    return _check_patterns_in_file(path, [r"selfdestruct"])


def check_need_addconstraint(index):
    """
    Check if the smart contract needs additional constraints by analyzing its AST.
    Specifically checks if the contract is a math-related library.
    """
    json_file_path = f"./output_ast/output_{index}.sol_json.ast"
    ast_data = _load_json(json_file_path)
    
    if ast_data is None:
        return False

    return _is_math_library_contract(ast_data)


def _load_json(path):
    """
    Load the JSON data from the specified file path.
    Returns the parsed contents or None if the file cannot be loaded.
    """
    try:
        with open(path, "r", encoding='utf-8') as ast_file:
            return json.load(ast_file)
    except FileNotFoundError:
        print(f"File not found: {path}")
        return None
    except json.JSONDecodeError:
        print(f"Error decoding JSON in file: {path}")
        return None


def _is_math_library_contract(ast_data):
    """
    Determine if the AST contains a math-related library contract.
    Returns True if the contract is a math library, False otherwise.
    """
    nodes = ast_data.get("nodes", [])
    
    for node in nodes:
        if node.get('nodeType') != "ContractDefinition":
            continue
        if node.get('contractKind') != "library":
            continue
        if "math" in node.get('name', "").lower():
            return True

    return False