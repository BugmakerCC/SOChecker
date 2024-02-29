import pandas as pd
import re
import os
import multiprocessing
import math
import time
import shutil
from sklearn.metrics.pairwise import cosine_similarity

share_record = dict()
threads = list()

file_name = "info.json"
core_num = 8
file_prefix = "./"
file_process_prefix = "./process/"
res_profix = "json"



def texThandle(text,str_to_replace,replacement_str):
    str_to_replace = '!' + str_to_replace + '!'
    replacement_str = '!' + replacement_str + '!'
    pattern_str = re.escape(str_to_replace)
    new_text = re.sub(pattern_str, replacement_str, text)
    return new_text

def fileProcess(line_begin,line_end,flag,dictionary):
    
    global share_record
    global file_name
    global cad_prefix
    global cad_profix
    global file_process_prefix
    global res_profix
    with open(cad_prefix + file_name + cad_profix, "r") as file,open(file_process_prefix + file_name + res_profix + str(flag) + cad_profix, 'w+') as target:
        data= file.readlines()
        for index in range(line_begin,line_end):
            line = data[index]
            if line:
                if line in share_record:
                    resLine = share_record[line]
                else:
                    resLine = line
                    for longNet,net in dictionary.items():
                        if line.__len__() < longNet.__len__() + 2:
                            continue
                        if(texThandle(line,longNet,net) != line):
                            resLine = texThandle(line,longNet,net)
                            break
                    share_record[line] = resLine
                target.write(resLine)


def process_task(pid, dictionary,fname,cnum):
    
    global core_num
    global file_name
    global cad_profix

    file_name = fname
    core_num = cnum

    total_lines = len(open(cad_prefix + file_name + cad_profix, "r").readlines())
    chunk_size = math.ceil(total_lines / core_num)
    begin_line = (pid - 1) * chunk_size
    end_line = pid * chunk_size
    if pid == core_num:
        end_line = total_lines
    fileProcess(begin_line, end_line, pid, dictionary)

def mergeFiles():

    global core_num
    global file_name
    global cad_prefix
    global cad_profix
    global file_process_prefix
    global res_profix

    with open(cad_prefix + file_name + "_res" + cad_profix, "w+") as merged_file:
        for index in range(1,core_num+1):
            fName = file_process_prefix + file_name + res_profix + str(index) + cad_profix
            if not os.path.exists(fName):
                continue
            with open(fName, "r") as current_file:
                merged_file.write(current_file.read())

def run():

    if __name__ == "__main__":
        
        multiprocessing.freeze_support()

        os.chdir("..")

        if not preprocess():
            return

        start_time = time.time()

        dictionary = dict()


        processes = []
        for pid in range(1,core_num+1):
            process = multiprocessing.Process(target=process_task, args=(pid, dictionary, file_name, core_num))
            processes.append(process)
        
        sigprocess = multiprocessing.Process(target=showProgress,args=(file_name,core_num))
        processes.append(sigprocess)

        for process in processes:
            process.start()

        for process in processes:
            process.join()

        mergeFiles()

        end_time  = time.time()
        execution_time = end_time - start_time

        print(f"程序执行时间: {execution_time:.2f} 秒")

        input("执行完成: ")
    
def preprocess():

    global file_name
    global core_num
    global file_process_prefix
    
    shutil.rmtree(file_process_prefix)  # 递归删除文件夹及其内容
    os.makedirs("./process")

    if not os.path.exists(cad_prefix + file_name + cad_profix):
        print("文件不存在")
        return False
    if os.path.exists(cad_prefix + file_name + res_profix + cad_profix):
        os.remove(cad_prefix + file_name + res_profix + cad_profix)
    core_num = input("需要启动的进程数量(建议和cpu核心数相同): ")
    try:
        core_num = int(core_num)
    except ValueError:
        print(f"字符串 '{core_num}' 无法转化为整数")
        return False
    if core_num > 32 or core_num <= 0:
        print("核心数量太多或者太少")
        return False
    return True

def check_expression(expressionInfo):

    if expressionInfo['expression'] is None:
        return False
    if 'nodeType' not in expressionInfo['expression'].keys():
        return False
    if expressionInfo['expression']['nodeType'] is None:
        return False
    if expressionInfo['expression']['nodeType'] != "FunctionCall":
        return False
    if expressionInfo['expression']['expression']['nodeType'] != "MemberAccess":
        return False
    expressionType = expressionInfo['expression']['expression']['memberName']
    if expressionType == "transfer" or expressionType == "send" or expressionType == "value":
        return True
    return False

def recur_statement(statement,fileName):
    if statement['nodeType'] == "ExpressionStatement":
        if check_expression(statement):
            return True
        else:
            return False
    if statement['nodeType'] == "IfStatement":
        if not statement['falseBody'] is None:
            if statement['falseBody']['nodeType'] == "Block":
                for statement_recur in statement['falseBody']['statements']:
                    recur_statement(statement_recur,fileName)
            else:
                recur_statement(statement['falseBody'],fileName)
        if not statement['trueBody'] is None:
            if statement['trueBody']['nodeType'] == "Block":
                for statement_recur in statement['trueBody']['statements']:
                    recur_statement(statement_recur,fileName)
            else:
                recur_statement(statement['trueBody'],fileName)
    elif statement['nodeType'] == "ForStatement":
        if statement['body']['nodeType'] == "Block":
            for statement_recur in statement['body']['statements']:
                recur_statement(statement_recur,fileName)
        else:
            recur_statement(statement['body'])
    elif statement['nodeType'] == "WhileStatement":
        if statement['body']['nodeType'] == "Block":
            for statement_recur in statement['body']['statements']:
                recur_statement(statement_recur,fileName)
        else:
             recur_statement(statement['body'],fileName)
    elif statement['nodeType'] == "Return":
        return check_expression(statement)
    else:
        if statement['nodeType'] != "VariableDeclarationStatement" and  statement['nodeType'] != "EmitStatement" and statement['nodeType'] != "Throw" and statement['nodeType'] != "Break" and statement['nodeType'] != "InlineAssembly":
            msg = "missing statement type" + statement['nodeType'] + fileName
        return False

def showProgress(fname,cnum):

    global core_num
    global file_name
    global cad_profix
    global file_process_prefix
    global res_profix

    file_name = fname
    core_num = cnum

    file_name = fname
    while True:
        total_lines = len(open(cad_prefix + file_name + cad_profix, "r").readlines())
        handle_lines = 0
        for pid in range(1,core_num+1):
            if os.path.exists(file_process_prefix + file_name + res_profix + str(pid) + cad_profix):
                handle_lines = handle_lines + len(open(file_process_prefix + file_name + res_profix + str(pid) + cad_profix, 'r').readlines())

        print(f"当前处理进度百分之{handle_lines / total_lines * 100:.2f}")
        if handle_lines >= total_lines:
            return
        time.sleep(60)


run()


# 完整合约类型 input中包含contract字段 正则匹配 全部编译 AST
# 完整函数类型 input中包含有function name 做一个正则匹配   多个则都记录 函数名字+参数类型 得到函数哈希 用于之后构建CFG的用来进行流筛选的依据
# 程序语句  在生数据中 截取每个function片段  使用 scikit-learn 库计算TF-IDF向量和余弦相似度。 设计一个阈值 高于这个默认匹配 记录此函数 用作后续的流分析
    #不完全匹配
    #完全匹配 
# 重入漏洞