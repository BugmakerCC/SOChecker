class analysis_unit:
    def __init__(self, index, unit_type):
        self.index = index
        self.type = unit_type    
        self.contracts = []
        self.functions = []
        self.function_sigs = []
        self.analysis_contracts = []
        self.contract_results = []
        self.ast_contract_nodes = []
        self.passed_compilation = False
        self.is_over_time = True
    
    # Contract Methods
    def add_contract(self, contract):
        self.contracts.append(contract)
    
    def get_contracts(self):
        return self.contracts
    
    def add_analysis_contract(self, contract):
        self.analysis_contracts.append(contract)
    
    def get_analysis_contracts(self):
        return self.analysis_contracts
    
    def copy_to_analysis(self):
        self.analysis_contracts = self.contracts[:]
    
    # Function Methods
    def add_function(self, function):
        self.functions.append(function)
    
    def get_functions(self):
        return self.functions
    
    # Function Signature Methods
    def add_function_sig(self, sig):
        self.function_sigs.append(sig)
    
    def get_function_sigs(self):
        return self.function_sigs
    
    # AST Contract Node Methods
    def add_ast_contract_node(self, contract_node):
        self.ast_contract_nodes.append(contract_node)
    
    def get_ast_contract_nodes(self):
        return self.ast_contract_nodes
    
    # Result Methods
    def add_contract_result(self, result):
        self.contract_results.append(result)
    
    def get_contract_results(self):
        return self.contract_results
    
    # Compilation Status Methods
    def mark_passed_compilation(self):
        self.passed_compilation = True
    
    def has_passed_compilation(self):
        return self.passed_compilation
    
    # Overtime Status Methods
    def mark_not_over_time(self):
        self.is_over_time = False
    
    def is_over_time(self):
        return self.is_over_time
    
    # Other
    def get_index(self):
        return self.index
    
    def get_type(self):
        return self.type