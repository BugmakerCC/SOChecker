import pandas as pd
import os

def initialize_excel_dict():
    
    """
    Initializes a dictionary to store the results of smart contract vulnerability detection.
    
    The dictionary keys represent different types of vulnerabilities. 
    The '_label' suffix indicates the ground truth labels (extracted from the dataset), 
    the '_detect' suffix indicates the results detected by the tool, 
    and '_FP' and '_FN' stand for false positives and false negatives, respectively.
    """
      
    return {
        'Index': [], 'Pass_compile': [],
        'Reentrancy_label': [], 'Reentrancy_detect': [], 'Reentrancy_FP': [], 'Reentrancy_FN': [],
        'Access_Control_label': [], 'Access_Control_detect': [], 'Access_Control_FP': [], 'Access_Control_FN': [],
        'Arithmetic_Issues_label': [], 'Arithmetic_Issues_detect': [], 'Arithmetic_Issues_FP': [], 'Arithmetic_Issues_FN': [],
        'UEC_label': [], 'UEC_detect': [], 'UEC_FP': [], 'UEC_FN': [],
        'Dos_label': [], 'Dos_detect': [], 'Dos_FP': [], 'Dos_FN': [],
        'RAD_label': [], 'RAD_detect': [], 'RAD_FP': [], 'RAD_FN': [],
        'BID_label': [], 'BID_detect': [], 'BID_FP': [], 'BID_FN': [],
        'TOD_label': [], 'TOD_detect': [], 'TOD_FP': [], 'TOD_FN': [],
        'SAA_label': [], 'SAA_detect': [], 'SAA_FP': [], 'SAA_FN': []
    }

def update_excel_dict_for_failed_compile(excelDict):

    """
    Updates the dictionary for cases where the contract failed to compile.
    
    In smart contract security research, the ability of a contract to compile
    is critical as it affects the validity of static analysis (Li et al., 2020).
    This function sets detection results for various vulnerabilities to 'False' for 
    contracts that did not successfully compile.
    """

    fields_to_update = ['Pass_compile', 'UEC_detect', 'UEC_FP', 'UEC_FN', 'BID_detect', 'BID_FP', 'BID_FN',
                        'SAA_detect', 'SAA_FP', 'SAA_FN', 'TOD_detect', 'TOD_FP', 'TOD_FN', 'RAD_detect',
                        'RAD_FP', 'RAD_FN', 'Reentrancy_detect', 'Reentrancy_FP', 'Reentrancy_FN', 'Dos_detect',
                        'Dos_FP', 'Dos_FN', 'Arithmetic_Issues_detect', 'Arithmetic_Issues_FP', 'Arithmetic_Issues_FN',
                        'Access_Control_detect', 'Access_Control_FP', 'Access_Control_FN']
    for field in fields_to_update:
        excelDict[field].append(False)

def process_contract_detection(contract, tags):

    """
    Processes the detection of vulnerabilities within a contract.

    This function updates the 'tags' dictionary, marking detected vulnerabilities.
    Each vulnerability (e.g., reentrancy, access control issues) is checked using specific contract methods.
    """
     
    if contract.get_UEC():
        tags['UEC'] = True
    if contract.get_BID():
        tags['BID'] = True
    if contract.get_SAA():
        tags['SAA'] = True
    if contract.get_TOD():
        tags['TOD'] = True
    if contract.get_REC():
        tags['REC'] = True
    if contract.get_DOS():
        tags['DOS'] = True
    if contract.get_integer_over() or contract.get_integer_under():
        tags['AMI'] = True
    if contract.get_ORI() or contract.get_SLF():
        tags['ACC'] = True
    if contract.get_RAD():
        tags['RAD'] = True

def check_label_mismatch(excelDict, row, tag, label_field, detect_field, fp_field, fn_field):

    """
    Checks for mismatches between the detected vulnerabilities and the ground truth labels.
    
    If the tag (detected vulnerability) does not match the ground truth, 
    the result is categorized as either a false positive (FP) or false negative (FN). 
    """

    if tag:
        excelDict[detect_field].append(True)
    else:
        excelDict[detect_field].append(False)

    if row[label_field] != tag:
        if row[label_field]:
            excelDict[fn_field].append(True)
            excelDict[fp_field].append(False)
        else:
            excelDict[fp_field].append(True)
            excelDict[fn_field].append(False)
    else:
        excelDict[fp_field].append(False)
        excelDict[fn_field].append(False)

def process_unit_compile(unit, row, excelDict, index):

    """
    Processes the compilation of a smart contract unit and updates the detection results.
    
    This function handles multiple contracts in a compilation unit, checking for compilation success
    and detecting vulnerabilities in each contract. It is an essential part of static analysis in 
    """
        
    contracts = unit.get_contract_results()
    if len(contracts) == 0:
        update_excel_dict_for_failed_compile(excelDict)
        return
    # Initialize the tags for different vulnerabilities
    tags = {tag: False for tag in ['UEC', 'BID', 'SAA', 'TOD', 'REC', 'DOS', 'AMI', 'ACC', 'RAD']}
    for contract in contracts:
        process_contract_detection(contract, tags)

    # Update the dictionary for successful compilation
    excelDict['Pass_compile'].append(True)
    # Check for label mismatches and update the detection results accordingly
    check_label_mismatch(excelDict, row, tags['UEC'], 'Unchecked Return Values For Low Level Calls', 'UEC_detect', 'UEC_FP', 'UEC_FN')
    check_label_mismatch(excelDict, row, tags['BID'], 'Time manipulation', 'BID_detect', 'BID_FP', 'BID_FN')
    check_label_mismatch(excelDict, row, tags['SAA'], 'Short Address Attack', 'SAA_detect', 'SAA_FP', 'SAA_FN')
    check_label_mismatch(excelDict, row, tags['TOD'], 'Front-Running', 'TOD_detect', 'TOD_FP', 'TOD_FN')
    check_label_mismatch(excelDict, row, tags['RAD'], 'Bad Randomness', 'RAD_detect', 'RAD_FP', 'RAD_FN')
    check_label_mismatch(excelDict, row, tags['REC'], 'Reentrancy', 'Reentrancy_detect', 'Reentrancy_FP', 'Reentrancy_FN')
    check_label_mismatch(excelDict, row, tags['DOS'], 'Denial of Service', 'Dos_detect', 'Dos_FP', 'Dos_FN')
    check_label_mismatch(excelDict, row, tags['AMI'], 'Arithmetic Issues', 'Arithmetic_Issues_detect', 'Arithmetic_Issues_FP', 'Arithmetic_Issues_FN')
    check_label_mismatch(excelDict, row, tags['ACC'], 'Access Control', 'Access_Control_detect', 'Access_Control_FP', 'Access_Control_FN')

def read_label(input_map):

    """
    Reads the ground truth labels from an Excel file and processes smart contract compilation results.
    
    This function loads labeled data from 'label.xlsx' and cross-references it with the compilation results
    stored in 'input_map'. The processed results are then written to a new Excel file for further analysis.
    """
        
    excelData = pd.read_excel("./label.xlsx")
    excelDict = initialize_excel_dict()

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

        # Check if the contract's results exist in the input map
        if str(row['Index']) in input_map:
            unit = input_map[str(row['Index'])]
            if not unit.has_passed_compilation():
                update_excel_dict_for_failed_compile(excelDict)
                continue
            process_unit_compile(unit, row, excelDict, row['Index'])
        else:
            update_excel_dict_for_failed_compile(excelDict)
            # Log cases where the label exists but no corresponding contract in input map
            if not os.path.isfile(f"./input/input_{str(row['Index'])}.sol"):
                write_msg_compile(f"Label has but not contained in json {str(row['Index'])}")

    df = pd.DataFrame(excelDict)
    df.to_excel("./result.xlsx", index=False, header=True)
    print("success!")



def write_msg_compile(msg):
    with open("./nocompile.log",'a') as f:
        f.write(msg)
        f.write('\n')
        f.close()  