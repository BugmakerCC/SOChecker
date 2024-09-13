class BasicBlock:
    def __init__(self, start_address):
        self.start = start_address
        self.instructions = [] 
        self.eq_expressions = []
        self.is_zero_expressions = []
        self.valid = False
        self.path_condition = []
        self.end = None
        self.fall_to = None
        self.jump_target = None
        self.jump_to = None
        self.type = None
        self.branch_expression = None
    
    # Address-related methods
    def get_start_address(self):
        return self.start
    
    def set_end_address(self, end_address):
        self.end = end_address
    
    def get_end_address(self):
        return self.end
    
    # Control flow-related methods
    def set_fall_to(self, fall_to):
        self.fall_to = fall_to
    
    def get_fall_to(self):
        return self.fall_to
    
    def set_jump_target(self, jump_target):
        self.jump_target = jump_target
    
    def get_jump_target(self):
        return self.jump_target
    
    # Instruction-related methods
    def add_instruction(self, instruction):
        self.instructions.append(instruction)
    
    def get_instructions(self):
        return self.instructions
    
    # Expression-related methods
    def add_eq_expression(self, eq_expression):
        self.eq_expressions.append(eq_expression)
    
    def get_eq_expressions(self):
        return self.eq_expressions
    
    def add_is_zero_expression(self, is_zero_expression):
        self.is_zero_expressions.append(is_zero_expression)
    
    def get_is_zero_expressions(self):
        return self.is_zero_expressions
    
    # Block validity and type
    def activate_block(self):
        self.valid = True
    
    def is_block_valid(self):
        return self.valid
    
    def set_block_type(self, block_type):
        self.type = block_type
    
    def get_block_type(self):
        return self.type
    
    # Path condition methods
    def set_branch_expression(self, branch_expression):
        self.branch_expression = branch_expression
    
    def get_branch_expression(self):
        return self.branch_expression
    
    def add_path_condition(self, constraint):
        self.path_condition.append(constraint)
    
    def set_path_condition(self, path_condition):
        self.path_condition = path_condition
    
    def get_path_condition(self):
        return self.path_condition
    
    # Display method
    def display(self):
        print(f"BasicBlock(start: {self.start}, end: {self.end}, valid: {self.valid})")
