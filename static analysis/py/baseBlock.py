class BasicBlock:
    def __init__(self, start_address):
        self.start = start_address
        self.instructions = []  # each instruction is a string
        self.eqexpressions = []
    def get_start_address(self):
        return self.start
    def set_end_address(self,end_address):
        self.end = end_address
    def get_end_address(self):
        return  self.end
    def set_fall_to(self,fall_to):
        self.fall_to = fall_to
    def get_fall_to(self):
        return  self.fall_to
    def set_jump_target(self,jump_target):
        self.jump_target = jump_target
    def get_jump_target(self):
        return self.jump_target
    def add_instruction(self, instruction):
        self.instructions.append(instruction)
    def set_jump_to(self,jump_to):   
        self.jump_to = jump_to
    def get_jump_to(self):
        return self.jump_to
    def get_instructions(self):
        return self.instructions
    def add_eqexpression(self,eqexpression):
        self.eqexpressions.append(eqexpression)    
    def get_eqexpressions(self):
        return self.eqexpressions
    def set_block_type(self, type):
        self.type = type
    def get_block_type(self):
        return self.type
    def set_branch_expression(self, branch):
        self.branch_expression = branch
    def get_branch_expression(self):
        return self.branch_expression
    def display(self):
        print("================")

