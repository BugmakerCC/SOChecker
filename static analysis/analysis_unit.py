class analysis_unit:
    def __init__(self, index, type):
        self.index = index
        self.type = type    
        self.contract = []
        self.function = []
        self.functionSig = []
        self.analysisContract = []
        self.contractRes = []
        self.astContractNode = []
        self.pass_compile = False
    def addContract(self,contract):
        self.contract.append(contract)
    def getContract(self):
        return self.contract
    def addFunction(self,function):
        self.function.append(function)
    def getFunction(self):
        return self.function
    def addRes(self,res):
        self.contractRes.append(res)
    def getIndex(self):
        return self.index
    def getRes(self):
        return self.contractRes
    def getType(self):
        return self.type
    def addAnalysisContract(self,contract):
        self.analysisContract.append(contract)
    def getAnalysisContract(self):
        return self.analysisContract
    def copyToAanlysis(self):
        self.analysisContract = self.contract
    def addFunctionSig(self,sig):
        self.functionSig.append(sig)
    def getFunctionSig(self):
        return self.functionSig
    def addAstContractNode(self,contract):
        self.astContractNode.append(contract)
    def getAstContractNode(self):
        return self.astContractNode
    def make_pass_compile(self):
        self.pass_compile = True
    def is_pass_compile(self):
        return self.pass_compile