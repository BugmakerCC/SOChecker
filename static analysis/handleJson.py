import json
import re
import os
import shutil
import random
from analysis_unit import analysis_unit
from contract import contract
import pandas as pd
import time


solcVersionPath = "C:\\Users\\.solcx\\"

inputMap = {}

binProcess = "./process/"
runProcess = "./process-run/"

solFilePath = "./output/"

bin_full = "./bin-full/"
bin_run = "./bin-runtime/"
bin_creation = "./bin-creation/"

opcodes_runtime = "./opcodes-runtime/"
opcodes_creation = "./opcodes-creation/"

versionTag = []


def run():
   
    with open('./completion_v3.json', 'r',encoding='utf-8') as file:
    
        data = json.load(file)
        
        for key, value in data.items():
            numbers = re.findall(r'\d+', key)[0]
            inputFileName = "input_" + numbers + ".sol"
            outputFileName = "output_" + numbers + ".sol"

            with open("./input/" + inputFileName, "w", encoding='utf-8') as file1, open("./output/" + outputFileName, "w", encoding='utf-8') as file2:
                file1.write(value['input'])
                if(value['output'] == ""):
                    file2.write(value['input'])
                else:
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
            if not os.path.isfile("./output_ast/" + f +"_json.ast"):
                version = "0.8.9"
                solcCmd = solcVersionPath + "solc-v" + version + "\\" + "solc.exe"
                command_json = solcCmd + jsonChose + file_path + " -o " + "./output_ast"
                os.system(command_json)
                if not os.path.isfile("./output_ast/" + f +"_json.ast"):
                    write_msg_compile("write error>>> "+ f)
                else:
                    versionTag.append(get_key(f))


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
                    if unit.getFunction().__len__():
                        for info in idInfo:
                            if info['nodeType'] != "ContractDefinition":
                                continue
                            if info['contractKind'] != "contract":
                                continue
                            for funcInfo in info['nodes']:
                                if funcInfo['nodeType'] != "FunctionDefinition":
                                    continue
                                if not 'kind' in funcInfo:
                                    continue
                                if funcInfo['kind'] != "function":
                                    continue
                                if "functionSelector" in funcInfo:
                                    unit.addFunctionSig(funcInfo['functionSelector'])
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
                cmatches = re.findall(r'contract\s+(\w+)\s*{', solstr)
                cmatches = list(set(cmatches))
                if cmatches.__len__() == 0:
                    write_msg_compile("meaning1 less sol " + fkey)
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
                cmatches = re.findall(r'contract\s+(\w+)\s*{', solstr)
                cmatches = list(set(cmatches))
                if cmatches.__len__() == 0:
                    write_msg_compile("meaning2 less sol " + rkey)
                    continue
                else:
                    for item in cmatches:
                        unit.addAnalysisContract(item)
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



def compileLatter(index,fileName,contractName,solcCmd,unit):
    
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

    contractName = contractName + "_" + unit.getIndex()
    fileFullName = contractName + ".bin"
    fileRunName = contractName + ".bin-runtime"
    fileCreationName = contractName + ".bin-creation"
    opcodesRunName = contractName + ".opcodes-runtime"
    opcodesCreationName = contractName + ".opcodes-creation"

    while os.path.isfile(bin_full + fileFullName):
        random_number = random.randint(1,10)
        contractName = contractName + "_" + str(random_number)
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

    command_evm_run = "evm disasm " + bin_run + fileRunName + " > " + opcodes_runtime + opcodesRunName
    os.system(command_evm_run)

    if not os.path.isfile(opcodes_runtime + opcodesRunName):
        write_msg("opcodes run error" + command_evm_run + " " + opcodes_runtime + opcodesRunName)
        return False
    
    command_evm_creation = "evm disasm " + bin_creation + fileCreationName + " > " + opcodes_creation + opcodesCreationName
    os.system(command_evm_creation)

    if not os.path.isfile(opcodes_creation + opcodesCreationName):
        write_msg("opcodes creation error" + command_evm_creation + " " + opcodes_creation + opcodesCreationName)
        return False
  
    contract_anlysis = contract(contractName,index,unit.getFunctionSig())
    unit.addRes(contract_anlysis)

    return True

def read_label():

    excelData = pd.read_excel("./label.xlsx")

    excelDict = {
        
        'Index' : [],
        'Pass_compile' : [],

        
        'Reentrancy_label' : [],
        'Reentrancy_detect' : [],
        'Reentrancy_FP' : [],
        'Reentrancy_FN' : [],


        'Access_Control_label' : [],
        'Access_Control_detect' : [],
        'Access_Control_FP' : [],
        'Access_Control_FN' : [],


        'Arithmetic_Issues_label' : [],
        'Arithmetic_Issues_detect' : [],
        'Arithmetic_Issues_FP' : [],
        'Arithmetic_Issues_FN' : [],

        'UEC_label' : [],
        'UEC_detect' : [],
        'UEC_FP' : [],
        'UEC_FN' : [],


        'Dos_label' : [],
        'Dos_detect' : [],
        'Dos_FP' : [],
        'Dos_FN' : [],

        'RAD_label' : [],
        'RAD_detect' : [],
        'RAD_FP' : [],
        'RAD_FN' : [],

        'BID_label' : [],
        'BID_detect' : [],
        'BID_FP' : [],
        'BID_FN' : [],

        'TOD_label' : [],
        'TOD_detect' : [],
        'TOD_FP' : [],
        'TOD_FN' : [],

        'SAA_label' : [],
        'SAA_detect' : [],
        'SAA_FP' : [],
        'SAA_FN' : [],

    }

    for _, row in excelData.iterrows():



        excelDict['Index'].append(row['Index'])

        excelDict['Reentrancy_label'].append(row['Reentrancy'])
        excelDict['Access_Control_label'].append(row['Access Control'])
        excelDict['Arithmetic_Issues_label'].append(row['Arithmetic Issues'])
        excelDict['UEC_label'].append(row['Unchecked Return Values For Low Level Calls'])
        excelDict['Dos_label'].append(row['Denial of Service'])
        excelDict['RAD_label'].append(row['Bad Randomness'])
        excelDict['BID_label'].append(row['Time manipulation'])
        excelDict['TOD_label'].append(row['Front-Running'])
        excelDict['SAA_label'].append(row['Short Address Attack'])


        if str(row['Index']) in inputMap:

            unit = inputMap[str(row['Index'])]

            if not unit.is_pass_compile():
                excelDict['Pass_compile'].append(False)
                excelDict['UEC_detect'].append(False)
                excelDict['UEC_FP'].append(False)
                excelDict['UEC_FN'].append(False)
                excelDict['BID_detect'].append(False)
                excelDict['BID_FP'].append(False)
                excelDict['BID_FN'].append(False)
                excelDict['SAA_detect'].append(False)
                excelDict['SAA_FP'].append(False)
                excelDict['SAA_FN'].append(False)
                excelDict['TOD_detect'].append(False)
                excelDict['TOD_FP'].append(False)
                excelDict['TOD_FN'].append(False)
                excelDict['RAD_detect'].append(False)
                excelDict['RAD_FP'].append(False)
                excelDict['RAD_FN'].append(False)
                excelDict['Reentrancy_detect'].append(False)
                excelDict['Reentrancy_FP'].append(False)
                excelDict['Reentrancy_FN'].append(False)
                excelDict['Dos_detect'].append(False)
                excelDict['Dos_FP'].append(False)
                excelDict['Dos_FN'].append(False)
                excelDict['Arithmetic_Issues_detect'].append(False)
                excelDict['Arithmetic_Issues_FP'].append(False)
                excelDict['Arithmetic_Issues_FN'].append(False)
                excelDict['Access_Control_detect'].append(False)
                excelDict['Access_Control_FP'].append(False)
                excelDict['Access_Control_FN'].append(False)
                continue

            contracts = unit.getRes()

            if len(contracts) == 0:

                excelDict['Pass_compile'].append(False)
                excelDict['UEC_detect'].append(False)
                excelDict['UEC_FP'].append(False)
                excelDict['UEC_FN'].append(False)
                excelDict['BID_detect'].append(False)
                excelDict['BID_FP'].append(False)
                excelDict['BID_FN'].append(False)
                excelDict['SAA_detect'].append(False)
                excelDict['SAA_FP'].append(False)
                excelDict['SAA_FN'].append(False)
                excelDict['TOD_detect'].append(False)
                excelDict['TOD_FP'].append(False)
                excelDict['TOD_FN'].append(False)
                excelDict['RAD_detect'].append(False)
                excelDict['RAD_FP'].append(False)
                excelDict['RAD_FN'].append(False)
                excelDict['Reentrancy_detect'].append(False)
                excelDict['Reentrancy_FP'].append(False)
                excelDict['Reentrancy_FN'].append(False)
                excelDict['Dos_detect'].append(False)
                excelDict['Dos_FP'].append(False)
                excelDict['Dos_FN'].append(False)
                excelDict['Arithmetic_Issues_detect'].append(False)
                excelDict['Arithmetic_Issues_FP'].append(False)
                excelDict['Arithmetic_Issues_FN'].append(False)
                excelDict['Access_Control_detect'].append(False)
                excelDict['Access_Control_FP'].append(False)
                excelDict['Access_Control_FN'].append(False)
                continue

            
            excelDict['Pass_compile'].append(True)

            UECtag = False

            BIDtag = False

            SAAtag = False

            TODtag = False

            RADtag = False

            RECtag = False

            DOStag = False

            AMItag = False

            ACCtag= False

            for contract in contracts:
            
                if contract.get_UEC():
                    UECtag = True

                if contract.get_BID():
                    BIDtag = True

                if contract.get_SAA():
                    SAAtag = True
                
                if contract.get_TOD():
                    TODtag = True

                if contract.get_REC():
                    RECtag = True

                if contract.get_DOS():
                    DOStag = True

                if contract.get_integer_over() or contract.get_integer_under():    
                    AMItag = True
                
                if contract.get_ORI() or contract.get_SLF():    
                    ACCtag = True

                if contract.get_RAD():
                    RADtag = True

            if UECtag:
                excelDict['UEC_detect'].append(True)
            else:
                excelDict['UEC_detect'].append(False)

            if row['Unchecked Return Values For Low Level Calls'] != UECtag:
                if row['Unchecked Return Values For Low Level Calls'] == True:
                    excelDict['UEC_FN'].append(True)
                    excelDict['UEC_FP'].append(False)
                else:
                    excelDict['UEC_FP'].append(True)
                    excelDict['UEC_FN'].append(False)
            else:
                excelDict['UEC_FP'].append(False)
                excelDict['UEC_FN'].append(False)
            
            if BIDtag:
                excelDict['BID_detect'].append(True)
            else:
                excelDict['BID_detect'].append(False)

            if row['Time manipulation'] != BIDtag:
                if row['Time manipulation'] == True:
                    excelDict['BID_FN'].append(True)
                    excelDict['BID_FP'].append(False)
                else:
                    excelDict['BID_FP'].append(True)
                    excelDict['BID_FN'].append(False)
            else:
                excelDict['BID_FP'].append(False)
                excelDict['BID_FN'].append(False)

            if SAAtag:
                excelDict['SAA_detect'].append(True)
            else:
                excelDict['SAA_detect'].append(False)

            if row['Short Address Attack'] != SAAtag:
                if row['Short Address Attack'] == True:
                    excelDict['SAA_FN'].append(True)
                    excelDict['SAA_FP'].append(False)
                else:
                    excelDict['SAA_FP'].append(True)
                    excelDict['SAA_FN'].append(False)
            else:
                excelDict['SAA_FP'].append(False)
                excelDict['SAA_FN'].append(False)
            
            if TODtag:
                excelDict['TOD_detect'].append(True)
            else:
                excelDict['TOD_detect'].append(False)

            if row['Front-Running'] != TODtag:
                if row['Front-Running'] == True:
                    excelDict['TOD_FN'].append(True)
                    excelDict['TOD_FP'].append(False)
                else:
                    excelDict['TOD_FP'].append(True)
                    excelDict['TOD_FN'].append(False)
            else:
                excelDict['TOD_FP'].append(False)
                excelDict['TOD_FN'].append(False)

            if RADtag:
                excelDict['RAD_detect'].append(True)
            else:
                excelDict['RAD_detect'].append(False)
            
            if row['Bad Randomness'] != RADtag:
                if row['Bad Randomness'] == True:
                    excelDict['RAD_FN'].append(True)
                    excelDict['RAD_FP'].append(False)
                else:
                    excelDict['RAD_FP'].append(True)
                    excelDict['RAD_FN'].append(False)
            else:
                excelDict['RAD_FP'].append(False)
                excelDict['RAD_FN'].append(False)


            if  RECtag:
                excelDict['Reentrancy_detect'].append(True)
            else:
                excelDict['Reentrancy_detect'].append(False)

            if row['Reentrancy'] != RECtag:
                if row['Reentrancy'] == True:
                    excelDict['Reentrancy_FN'].append(True)
                    excelDict['Reentrancy_FP'].append(False)
                else:
                    excelDict['Reentrancy_FP'].append(True)
                    excelDict['Reentrancy_FN'].append(False)
            else:
                excelDict['Reentrancy_FP'].append(False)
                excelDict['Reentrancy_FN'].append(False)

            
            if  DOStag:
                excelDict['Dos_detect'].append(True)
            else:
                excelDict['Dos_detect'].append(False)

            if row['Denial of Service'] !=  DOStag:
                if row['Denial of Service'] == True:
                    excelDict['Dos_FN'].append(True)
                    excelDict['Dos_FP'].append(False)
                else:
                    excelDict['Dos_FP'].append(True)
                    excelDict['Dos_FN'].append(False)
            else:
                excelDict['Dos_FP'].append(False)
                excelDict['Dos_FN'].append(False)

                
            if AMItag:    
                excelDict['Arithmetic_Issues_detect'].append(True)
            else:
                excelDict['Arithmetic_Issues_detect'].append(False)

            if row['Arithmetic Issues'] != AMItag:
                if row['Arithmetic Issues'] == True:
                    excelDict['Arithmetic_Issues_FN'].append(True)
                    excelDict['Arithmetic_Issues_FP'].append(False)
                else:
                    excelDict['Arithmetic_Issues_FP'].append(True)
                    excelDict['Arithmetic_Issues_FN'].append(False)
            else:
                excelDict['Arithmetic_Issues_FP'].append(False)
                excelDict['Arithmetic_Issues_FN'].append(False)

    
            if ACCtag:    
                excelDict['Access_Control_detect'].append(True)
            else:
                excelDict['Access_Control_detect'].append(False)

            if row['Access Control'] != ACCtag:
                if row['Access Control'] == True:
                    excelDict['Access_Control_FN'].append(True)
                    excelDict['Access_Control_FP'].append(False)
                else:
                    excelDict['Access_Control_FP'].append(True)
                    excelDict['Access_Control_FN'].append(False)
            else:
                excelDict['Access_Control_FP'].append(False)
                excelDict['Access_Control_FN'].append(False)

           
        else:
            excelDict['Pass_compile'].append(False)
            excelDict['UEC_detect'].append(False)
            excelDict['UEC_FP'].append(False)
            excelDict['UEC_FN'].append(False)
            excelDict['BID_detect'].append(False)
            excelDict['BID_FP'].append(False)
            excelDict['BID_FN'].append(False)
            excelDict['SAA_detect'].append(False)
            excelDict['SAA_FP'].append(False)
            excelDict['SAA_FN'].append(False)
            excelDict['TOD_detect'].append(False)
            excelDict['TOD_FP'].append(False)
            excelDict['TOD_FN'].append(False)
            excelDict['RAD_detect'].append(False)
            excelDict['RAD_FP'].append(False)
            excelDict['RAD_FN'].append(False)
            excelDict['Reentrancy_detect'].append(False)
            excelDict['Reentrancy_FP'].append(False)
            excelDict['Reentrancy_FN'].append(False)
            excelDict['Dos_detect'].append(False)
            excelDict['Dos_FP'].append(False)
            excelDict['Dos_FN'].append(False)
            excelDict['Arithmetic_Issues_detect'].append(False)
            excelDict['Arithmetic_Issues_FP'].append(False)
            excelDict['Arithmetic_Issues_FN'].append(False)
            excelDict['Access_Control_detect'].append(False)
            excelDict['Access_Control_FP'].append(False)
            excelDict['Access_Control_FN'].append(False)
            if not os.path.isfile("./input/input_"+str(row['Index'])+".sol"):
                write_msg_compile("label has but not contain in json " + str(row['Index']))
            continue
    df = pd.DataFrame(excelDict)
    df.to_excel("./result.xlsx", index=False, header=True)
    print("success!") 


def compileInputMap():
    global inputMap

    for index,unit in inputMap.items():
        
      
        print("now compile index>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",index)

        fileName = "output_" + index + ".sol"
        jsonName = "output_" + index + ".sol_json.ast"

        if not os.path.isfile("./output_ast/"+jsonName):
            write_msg_compile("compile error>>>>>> " + index)
            continue

        analysisContract =  unit.getAnalysisContract()
        
        

        for contractName in analysisContract:

            version = getVersion(solFilePath + fileName)

            if index in versionTag:
                version = "0.8.9"

            clearProcess()

            solcCmd = solcVersionPath + "solc-v" + version + "\\" + "solc.exe"
            
            command_full = solcCmd + " --bin " + solFilePath + fileName + " -o " + binProcess
            os.system(command_full)

            if contractName in unit.getAstContractNode():

                if compileLatter(index,fileName,contractName,solcCmd,unit):
                    unit.make_pass_compile()
                else:
                    continue
            else:
                if unit.getAstContractNode().__len__() > 0 :
                    for astContract in unit.getAstContractNode():

                        if  compileLatter(index,fileName,astContract,solcCmd,unit):
                            unit.make_pass_compile()
                        else:
                           
                            continue
                else:
                    continue  

        if not unit.is_pass_compile():
            write_msg_compile("meaning less sol>>>>>> " + index)


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

def write_msg_compile(msg):
    with open("./nocompile.log",'a') as f:
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

    cleanLog()

def write_res(msg):
    with open("./result.log",'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()

def finalRun():
    clearAll() 
    run()
    make_ast()
    handle_input()
    cleanCompileFile()
    initial_map()
    handle_ast()
    compileInputMap()
    read_label()

# finalRun()

