import six
from z3 import *

def ceil32(x):
    """
    Computes the smallest multiple of 32 greater than or equal to `x`.
    
    :param x: The input integer.
    :return: The smallest multiple of 32 that is greater than or equal to `x`.
    """
    return x if x % 32 == 0 else x + 32 - (x % 32)

def is_symbolic(value):
    """
    Checks if a given value is symbolic (i.e., not a real integer).
    
    :param value: The value to check.
    :return: True if the value is symbolic, False if it is a real integer.
    """
    return not isinstance(value, six.integer_types)

def is_real(value):
    """
    Checks if a given value is a real integer.
    
    :param value: The value to check.
    :return: True if the value is a real integer, False if it is symbolic.
    """
    return isinstance(value, six.integer_types)

def are_all_real(*args):
    """
    Checks if all given arguments are real integers.
    
    :param args: A variable number of arguments to check.
    :return: True if all arguments are real integers, False otherwise.
    """
    for element in args:
        if is_symbolic(element):
            return False
    return True

def is_different(flow1, flow2):
    """
    Compares two execution flows to check if they are different based on symbolic execution.

    :param flow1: The first execution flow (a list of expressions).
    :param flow2: The second execution flow (a list of expressions).
    :return: 1 if the flows are different, 0 if they are identical.
    """
    if len(flow1) != len(flow2):
        return 1

    n = len(flow1)
    for i in range(n):
        if flow1[i] == flow2[i]:
            continue
        
        try:
            # Create symbolic condition for inequality between corresponding elements in the flows
            tx_cd = Or(Not(flow1[i][0] == flow2[i][0]),
                       Not(flow1[i][1] == flow2[i][1]))
            solver = Solver()
            solver.add(tx_cd)
            
            if solver.check() == sat:
                return 1
        except Exception:
            return 1
    return 0

def to_symbolic(value):
    """
    Converts a real integer to a Z3 symbolic bitvector of 256 bits, if necessary.
    
    :param value: The input value, either symbolic or a real integer.
    :return: A Z3 symbolic expression representing the value.
    """
    if is_real(value):
        return BitVecVal(value, 256)
    return value

def to_unsigned(value):
    """
    Converts a signed integer to its unsigned representation in the 256-bit range.
    
    :param value: The signed integer value.
    :return: The unsigned integer representation.
    """
    if value < 0:
        return value + 2**256
    return value

def to_signed(value):
    """
    Converts an unsigned 256-bit integer to its signed representation.
    
    :param value: The unsigned integer value.
    :return: The signed integer representation.
    """
    if value > 2**255:
        return (2**256 - value) * (-1)
    return value

def check_satisfiability(solver, pop_if_exception=True):
    """
    Checks the satisfiability of the constraints in the given Z3 solver.
    
    :param solver: A Z3 solver containing the constraints.
    :param pop_if_exception: If True, the solver will pop the latest context if an exception occurs.
    :return: The result of the satisfiability check (sat, unsat, or unknown).
    """
    try:
        result = solver.check()
        if result == unknown:
            raise Z3Exception(solver.reason_unknown())
    except Exception as e:
        if pop_if_exception:
            solver.pop()
        raise e
    return result