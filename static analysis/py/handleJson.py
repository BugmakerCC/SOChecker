import json
import re
import os
import shutil
import random
from analysis_unit import analysis_unit
from contract import contract


solcVersionPath = "C:\\Users\\yafei\\.solcx\\"

inputMap = {}

binProcess = "./process/"
runProcess = "./process-run/"

solFilePath = "./output/"

bin_full = "./bin-full/"
bin_run = "./bin-runtime/"
bin_creation = "./bin-creation/"

opcodes_runtime = "./opcodes-runtime/"
opcodes_creation = "./opcodes-creation/"


def run():
    with open('./info_filtered_merged.json', 'r',encoding='utf-8') as file:
        
        data = json.load(file)
        
        for key, value in data.items():
            numbers = re.findall(r'\d+', key)[0]
            inputFileName = "input_" + numbers + ".sol"
            outputFileName = "output_" + numbers + ".sol"
            if(value['output'] == ""):
                continue
            with open("./input/" + inputFileName, "w", encoding='utf-8') as file1, open("./output/" + outputFileName, "w", encoding='utf-8') as file2:
                file1.write(value['input'])
                file2.write(value['output'])

def make_ast():

    list_dirs = os.walk("./output")
    for root,_,files in list_dirs:
        for f in files: 
            file_path = os.path.join(root,f)
            version = getVersion(file_path)
            if version == "mismatch":
                write_msg("version not match "+f)
                continue
            jsonChose = " --ast-compact-json "
            numlist = version.split('.')
            pre = int(numlist[1].strip())
            pro = int(numlist[2].strip())
            if pre == 4 and pro <= 11:
                write_msg("low version " + f)
                continue
            if not os.path.exists(solcVersionPath + "solc-v" + version):
                write_msg("no version "+ version)
                continue
            solcCmd = solcVersionPath + "solc-v" + version + "\\" + "solc.exe"
            command_json = solcCmd + jsonChose + file_path + " -o " + "./output_ast"
            if not os.path.isfile(file_path):
                write_msg("no sol file")
                continue
            os.system(command_json)


def handle_input():
    list_dirs = os.walk("./input")
    for root,_,files in list_dirs:
        for f in files: 
            file_path = os.path.join(root,f)
            with open(file_path, "r", encoding='utf-8') as input_file:
                solstr = input_file.read();
                cmatches = re.findall(r'contract\s+(\w+)\s+.*{', solstr)
                cmatches = list(set(cmatches))
                if(cmatches.__len__() > 0):
                    cinfo = ""
                    for cmatch in cmatches:
                        cinfo = cinfo + cmatch + " "
                    write_log("./contract.log",f +" "+str(cmatches.__len__()) + " " + cinfo)
                else:
                    fmatches = re.findall(r'function\s+(\w+)\s*\(', solstr)
                    fmatches = list(set(fmatches))
                    if(fmatches.__len__() > 0):
                        finfo = ""
                        for fmatch in fmatches:
                            finfo = finfo + fmatch + " "
                        write_log("./function.log",f +" "+ str(fmatches.__len__()) + " " + finfo)
                    else:
                        write_log("./record.log",f) 

def astGetNameById(id,idList):
    for key,value in idList.items():
        if value[0] == id:
            return key
    return ""

def handle_ast():

    global inputMap

    list_dirs = os.walk("./output_ast")
    for root,_,files in list_dirs:
        for f in files: 
            file_path = os.path.join(root,f)
            with open(file_path, "r", encoding='utf-8') as ast_file:
                key = get_key(f)
                if not key in inputMap:
                    continue
                unit = inputMap[key]
                contents = json.load(ast_file)
                idInfo = contents["nodes"]
                idList = contents["exportedSymbols"]

                for info in idInfo:
                    if info['nodeType'] != "ContractDefinition":
                        continue
                    if info['contractKind'] != "contract":
                        continue
                    unit.addAstContractNode(info['name'])

                if (unit.getType() == 1):
                    if (unit.getContract().__len__() == 1):
                        unit.addAnalysisContract(unit.getContract()[0])
                    else:
                        
                        AllNodesId = []
                        for contract in unit.getContract():
                            if contract in idList:
                                AllNodesId.append(idList[contract][0])

                        for contract in unit.getContract():
                            for info in idInfo:
                                if info['nodeType'] != "ContractDefinition":
                                    continue
                                if info['contractKind'] != "contract":
                                    continue
                                if info['name'] != contract:
                                    continue
                                for depandId in info['contractDependencies']:
                                    if depandId in AllNodesId:
                                        AllNodesId.remove(depandId)
                                else:
                                    continue
                        for nodeId in AllNodesId:
                            if astGetNameById(nodeId,idList) != "":
                                unit.addAnalysisContract(astGetNameById(nodeId,idList))
                elif (unit.getType() == 2):
                    continue
                elif (unit.getType() == 3):
                    continue
                else:
                    continue


def initial_map():

    global inputMap

    with open("./contract.log", "r", encoding='utf-8') as contract_file: 
        while True:
            line = contract_file.readline()
            if line == '':
                break
            content = line.split()
            ckey = get_key(content[0])
            ctype = 1
            unit = analysis_unit(ckey,ctype)
            for i in range(2,content.__len__()):
                unit.addContract(content[i])
            inputMap[ckey] = unit
    with open("./function.log", "r", encoding='utf-8') as function_file: 
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
                cmatches = re.findall(r'contract\s+(\w+)\s+.*{', solstr)
                cmatches = list(set(cmatches))
                if cmatches.__len__() == 0:
                    write_msg("function log not find contract" + fkey)
                    continue
                else:
                    unit.addAnalysisContract(cmatches[0])
            for i in range(2,content.__len__()):
                unit.addFunction(content[i])
            inputMap[fkey] = unit
    with open("./record.log", "r", encoding='utf-8') as record_file: 
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
                cmatches = re.findall(r'contract\s+(\w+)\s+.*{', solstr)
                cmatches = list(set(cmatches))
                if cmatches.__len__() == 0:
                    write_msg("record log not find contract" + rkey)
                    continue
                else:
                    unit.addAnalysisContract(cmatches[0])
            inputMap[rkey] = unit

        

def get_key(str):
    pattern = re.compile(r'\d+')
    matches = pattern.findall(str)
    return matches[0]


def getVersion(path):
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



def compileLatter(fileName,contractName,solcCmd,unit):
    
    fileFullName = contractName + ".bin"
    fileRunName = contractName + ".bin-runtime"
    fileCreationName = contractName + ".bin-creation"
    opcodesRunName = contractName + ".opcodes-runtime"
    opcodesCreationName = contractName + ".opcodes-creation"
    originFullName = binProcess + fileFullName
    originRunName = runProcess + fileRunName

    if not os.path.isfile(originFullName):
        write_msg("compile full error " + contractName)
        return False

    while os.path.isfile(bin_full + fileFullName):
        random_number = random.randint(1,10)
        contractName = contractName + str(random_number)
        fileFullName = contractName + ".bin"
        fileRunName = contractName + ".bin-runtime"
        fileCreationName = contractName + ".bin-creation"
        opcodesRunName = contractName + ".opcodes-runtime"
        opcodesCreationName = contractName + ".opcodes-creation"

    shutil.move(originFullName,bin_full + fileFullName)


    clearRunProcess()

    command_run = solcCmd + " --bin-runtime " + solFilePath + fileName + " -o " + runProcess
    os.system(command_run)

    if not os.path.isfile(originRunName):
        write_msg("compile run error" + command_run + " " + originRunName)
        return False

    shutil.move(originRunName,bin_run + fileRunName)
    
    with open(bin_full + fileFullName,'r',encoding='utf-8') as f:
        str_full = f.read()
        f.close()
    with open(bin_run + fileRunName,'r',encoding='utf-8') as f:   
        str_run = f.read()
        f.close()
    creation = str_full[:len(str_full)-len(str_run)]
    with open(bin_creation + fileCreationName,'w',encoding='utf-8') as f:   
        f.write(creation)
        f.close()

    # libraryHandel(bin_run + fileRunName)

    command_evm_run = "evm disasm " + bin_run + fileRunName + " > " + opcodes_runtime + opcodesRunName
    os.system(command_evm_run)

    if not os.path.isfile(opcodes_runtime + opcodesRunName):
        write_msg("opcodes run error" + command_evm_run + " " + opcodes_runtime + opcodesRunName)
    
    command_evm_creation = "evm disasm " + bin_creation + fileCreationName + " > " + opcodes_creation + opcodesCreationName
    os.system(command_evm_creation)

    if not os.path.isfile(opcodes_creation + opcodesCreationName):
        write_msg("opcodes creation error" + command_evm_creation + " " + opcodes_creation + opcodesCreationName)

    contract_anlysis = contract(contractName)
    unit.addRes(contract_anlysis)

    return True

def pre_check_SLF(path):
    with open(path,'r',encoding='utf-8') as file:
        for line in file:
            if "selfdestruct" in line:
                return True
    return False

def statistic_res():
    UEC_num = 0
    ORI_num = 0
    SLF_num = 0
    BID_num = 0
    HCA_num = 0
    SBE_num = 0
    NC_num = 0
    IOF_num = 0
    IUF_num = 0

    for index,unit in inputMap.items():
        contracts = unit.getRes()
        for contract in contracts:
            if contract.get_UEC():
                UEC_num = UEC_num + 1
                msg = unit.getIndex() + " : UEC detetced"
                write_statics("./UEC.log",msg)
            if contract.get_ORI():    
                ORI_num = ORI_num + 1
                msg = unit.getIndex() + " : ORI detetced"
                write_statics("./ORI.log",msg)
            if contract.get_SLF():    
                fileName = "output_" + index + ".sol"
                if not pre_check_SLF(solFilePath + fileName):
                    continue
                SLF_num = SLF_num + 1
                msg = unit.getIndex() + " : SLF detetced"
                write_statics("./SLF.log",msg)
            if contract.get_BID():    
                BID_num = BID_num + 1
                msg = unit.getIndex() + " : BID detetced"
                write_statics("./BID.log",msg)
            if contract.get_HCA():    
                HCA_num = HCA_num + 1
                msg = unit.getIndex() + " : HCA detetced"
                write_statics("./HCA.log",msg)
            if contract.get_integer_over():    
                IOF_num = IOF_num + 1
                msg = unit.getIndex() + " : IOF detetced"
                write_statics("./IOF.log",msg)
            if contract.get_integer_under():
                IUF_num = IUF_num + 1
                msg = unit.getIndex() + " : IUF detetced"
                write_statics("./IUF.log",msg)
            if contract.get_SBE():    
                SBE_num = SBE_num + 1
                msg = unit.getIndex() + " : SBE detetced"
                write_statics("./SBE.log",msg)
            if contract.get_NC():    
                NC_num = NC_num + 1
                msg = unit.getIndex() + " : NC detetced"
                write_statics("./NC.log",msg)
            
            # msg = unit.getIndex() + " " + str(contract.get_edges())
            # write_statics("./result.log",msg)
    print("UEC_num>>>>>>>>>>>>>>>>>>>>>>>>",UEC_num)
    print("ORI_num>>>>>>>>>>>>>>>>>>>>>>>>",ORI_num)
    print("SLF_num>>>>>>>>>>>>>>>>>>>>>>>>",SLF_num)
    print("BID_num>>>>>>>>>>>>>>>>>>>>>>>>",BID_num)
    print("HCA_num>>>>>>>>>>>>>>>>>>>>>>>>",HCA_num)
    print("IOF_num>>>>>>>>>>>>>>>>>>>>>>>>",IOF_num)
    print("IUF_num>>>>>>>>>>>>>>>>>>>>>>>>",IUF_num)
    print("SBE_num>>>>>>>>>>>>>>>>>>>>>>>>",SBE_num)
    print("NC_num>>>>>>>>>>>>>>>>>>>>>>>>",NC_num)



def compileInputMap():
    global inputMap

    for index,unit in inputMap.items():
        if unit.getAnalysisContract().__len__() == 0:
            continue
        fileName = "output_" + index + ".sol"
        analysisContract =  unit.getAnalysisContract()

        for contractName in analysisContract:

            version = getVersion(solFilePath + fileName)

            if not os.path.isfile(solFilePath + fileName):
                write_msg("error>>> file miss"+fileName)
                continue
            
            clearProcess()

            solcCmd = solcVersionPath + "solc-v" + version + "\\" + "solc.exe"
            
            command_full = solcCmd + " --bin " + solFilePath + fileName + " -o " + binProcess
            os.system(command_full)

            if contractName in unit.getAstContractNode():
                if not compileLatter(fileName,contractName,solcCmd,unit):
                    continue
            else:
                if unit.getAstContractNode().__len__() > 0 :
                    for astContract in unit.getAstContractNode():
                        if not compileLatter(fileName,astContract,solcCmd,unit):
                            continue
                else:
                    write_msg("no contract in " + fileName)
                    continue  
           

def cleanCompileFile():

    if os.path.exists(bin_full):
        shutil.rmtree(bin_full)
    os.mkdir(bin_full)
    if os.path.exists(bin_creation):
        shutil.rmtree(bin_creation)
    os.mkdir(bin_creation)
    if os.path.exists(bin_run):
        shutil.rmtree(bin_run)
    os.mkdir(bin_run)
    if os.path.exists(opcodes_runtime):
        shutil.rmtree(opcodes_runtime)
    os.mkdir(opcodes_runtime)
    if os.path.exists(opcodes_creation):
        shutil.rmtree(opcodes_creation)
    os.mkdir(opcodes_creation)

    cleanLog()

    

def cleanLog():
    with open("./error.log",'w') as f:
        f.flush()
        f.close()

    # with open("./UEC.log",'w') as f:
    #     f.flush()
    #     f.close()
    
    with open("./HCA.log",'w') as f:
        f.flush()
        f.close()

    # with open("./ORI.log",'w') as f:
    #     f.flush()
    #     f.close()
        
    # with open("./BID.log",'w') as f:
    #     f.flush()
    #     f.close()

    # with open("./IOF.log",'w') as f:
    #     f.flush()
    #     f.close()

    # with open("./IUF.log",'w') as f:
    #     f.flush()
    #     f.close()

    # with open("./SBE.log",'w') as f:
    #     f.flush()
    #     f.close()
    
    # with open("./SLF.log",'w') as f:
    #     f.flush()
    #     f.close()
    
    # with open("./NC.log",'w') as f:
    #     f.flush()
    #     f.close()


def libraryHandel(file_path):

    with open(file_path,'r') as f:
        str = f.read()
        res = re.search(r'(\_\_\.).*(\_\_)',str)
        if res:
            res_final = str[:res.start()] + str[res.end():]
            f.close()
            with open(file_path,'w') as w:
                w.write(res_final)
                w.close()
        else:
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

def clear():
    if os.path.exists("./output_ast/"):
        shutil.rmtree("./output_ast/")
    os.mkdir("./output_ast/")

def clearProcess():
    if os.path.exists("./process/"):
        shutil.rmtree("./process/")
    os.mkdir("./process/")

def clearRunProcess():
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

def write_res(msg):
    with open("./result.log",'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()


# run()
# clear()
# clearAll()
# make_ast()
# handle_input()

cleanCompileFile()

initial_map()

handle_ast()

compileInputMap()

statistic_res()
