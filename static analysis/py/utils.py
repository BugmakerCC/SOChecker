import six
from z3 import *
from z3.z3util import get_vars


def ceil32(x):
    return x if x % 32 == 0 else x + 32 - (x % 32)

def isSymbolic(value):
    return not isinstance(value, six.integer_types)

def isReal(value):
    return isinstance(value, six.integer_types)

def isAllReal(*args):
    for element in args:
        if isSymbolic(element):
            return False
    return True

def to_symbolic(number):
    if isReal(number):
        return BitVecVal(number, 256)
    return number

def to_unsigned(number):
    if number < 0:
        return number + 2**256
    return number

def to_signed(number):
    if number > 2**(256 - 1):
        return (2**(256) - number) * (-1)
    else:
        return number

def check_sat(solver, pop_if_exception=True):
    try:
        ret = solver.check()
        if ret == unknown:
            raise Z3Exception(solver.reason_unknown())
    except Exception as e:
        if pop_if_exception:
            solver.pop()
        raise e
    return ret