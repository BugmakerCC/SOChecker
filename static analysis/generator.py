class VariableGenerator:
    """
    A class for generating various types of variables used in program analysis or synthesis.
    This generator produces unique identifiers for stack variables, data variables, memory locations, and other arbitrary values.
    """

    def __init__(self):
        """
        Initializes the counters for generating unique variables.
        Three counters are maintained:
        - `stack_count`: Tracks the number of stack variables generated.
        - `data_count`: Tracks the number of data variables generated.
        - `general_count`: A general counter for arbitrary variables.
        """
        self.stack_count = 0
        self.data_count = 0
        self.general_count = 0

    def generate_stack_variable(self):
        """
        Generates a unique identifier for a stack variable.
        
        :return: A string representing the stack variable in the format "sX" where X is an integer.
        """
        self.stack_count += 1
        return "s" + str(self.stack_count)

    def generate_data_variable(self, position=None):
        """
        Generates a unique identifier for a data variable, optionally using a specified position.
        
        :param position: An optional position to include in the variable name (default: None).
        :return: A string representing the data variable in the format "Id_X" where X is an integer.
        """
        self.data_count += 1
        return "Id_" + str(self.data_count)

    def generate_data_size(self):
        """
        Generates a standard identifier for representing the size of data.
        
        :return: A string "Id_size" representing the size of a data variable.
        """
        return "Id_size"

    def generate_memory_variable(self, address):
        """
        Generates a unique identifier for a memory location variable.
        
        :param address: The memory address associated with the variable.
        :return: A string representing the memory variable in the format "mem_X" where X is the address.
        """
        return "mem_" + str(address)

    def generate_arbitrary_variable(self):
        """
        Generates a unique identifier for an arbitrary variable.
        
        :return: A string representing the arbitrary variable in the format "some_var_X" where X is an integer.
        """
        self.general_count += 1
        return "some_var_" + str(self.general_count)

    def generate_function_signature(self):
        """
        Generates a unique identifier for a function signature.
        
        :return: A string representing the function signature in the format "function_signature_X" where X is an integer.
        """
        self.general_count += 1
        return "function_signature_" + str(self.general_count)

    def generate_arbitrary_MSTORE_variable(self):
        """
        Generates a unique identifier for an arbitrary MSTORE variable.
        
        :return: A string representing the MSTORE variable in the format "mstore_var_X" where X is an integer.
        """
        self.general_count += 1
        return "mstore_var_" + str(self.general_count)

    def generate_arbitrary_address_variable(self):
        """
        Generates a unique identifier for an arbitrary address variable.
        
        :return: A string representing the address variable in the format "some_address_X" where X is an integer.
        """
        self.general_count += 1
        return "some_address_" + str(self.general_count)

    def generate_owner_store_variable(self, position, var_name=""):
        """
        Generates a unique identifier for an owner store variable based on position and optional variable name.
        
        :param position: The position associated with the store variable.
        :param var_name: An optional variable name (default: empty string).
        :return: A string representing the owner store variable in the format "Ia_store-position-var_name".
        """
        return "Ia_store-%s-%s" % (str(position), var_name)

    def generate_gas_variable(self):
        """
        Generates a unique identifier for a gas variable.
        
        :return: A string representing the gas variable in the format "gas_X" where X is an integer.
        """
        self.general_count += 1
        return "gas_" + str(self.general_count)

    def generate_gas_price_variable(self):
        """
        Generates a standard identifier for the gas price variable.
        
        :return: A string "Ip" representing the gas price variable.
        """
        return "Ip"

    def generate_address_variable(self):
        """
        Generates a standard identifier for an address variable.
        
        :return: A string "Ia" representing the address variable.
        """
        return "Ia"

    def generate_caller_variable(self):
        """
        Generates a standard identifier for the caller variable.
        
        :return: A string "Is" representing the caller variable.
        """
        return "Is"

    def generate_origin_variable(self):
        """
        Generates a standard identifier for the origin variable.
        
        :return: A string "Io" representing the origin variable.
        """
        return "Io"

    def generate_balance_variable(self):
        """
        Generates a unique identifier for a balance variable.
        
        :return: A string representing the balance variable in the format "balance_X" where X is an integer.
        """
        self.general_count += 1
        return "balance_" + str(self.general_count)

    def generate_code_variable(self, address, position, byte_count):
        """
        Generates a unique identifier for a code variable based on address, position, and byte count.
        
        :param address: The address associated with the code.
        :param position: The position of the code within memory.
        :param byte_count: The number of bytes associated with the code.
        :return: A string representing the code variable in the format "code_address_position_byte_count".
        """
        return "code_" + str(address) + "_" + str(position) + "_" + str(byte_count)

    def generate_code_size_variable(self, address):
        """
        Generates a unique identifier for a code size variable based on the address.
        
        :param address: The address associated with the code.
        :return: A string representing the code size variable in the format "code_size_address".
        """
        return "code_size_" + str(address)