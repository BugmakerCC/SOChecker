# SOChecker
SOChecker is an automated security analysis tool designed for fragmented smart contract code.

For more information, please refer to our paper **Beyond Q\&A: Bridging Smart Contract Security Gaps in Code Snippets from *Stack Overflow***.

---
# *Code Completioner*
*Code Completioner* is employed to complete smart contract fragments, enabling the generation of a comprehensive and **compiled** contract while preserving the integrity of the original fragments. This guarantees the seamless advancement of our subsequent program analysis procedures.

### File Description
***Finetuning dataset.json*** is the file of dataset we use to finetune the model.

***llama-recipes*** is the official script used by *LLaMA* for model finetuning and inference. For more information, please refer to [Github repo](https://github.com/facebookresearch/llama-recipes).

***finetuned model*** is the file of model that we have finetuned.

### Running (Inference)
```
python llama-recipes/inference/eval_inference.py \
	--model_name "base_model_path"\
	--peft_model "peft_model_path" \
	--prompt_file "prompt_path(.json)" \
	--output_path "output_path(.json)" \
	--batch_size 1 \
	# 2>&1|tee "log_path(.log)"
```
The above instructions are stored in the file ***run.sh***.

Please note that the base model file for ***llama2-chat-13b*** is not included in our repository. Users are required to download it independently and accurately designate the file path using the "base_model_path" parameter.

---
# *Vulnerability Detector*
*Vulnerability Detector* employs symbolic execution to conduct security analysis on the program. It prunes the program's control flow graph and subsequently carries out vulnerability detection on the original code fragments. In terms of the scope of identified vulnerabilities, we adhere to the criteria outlined in [DASP10](https://dasp.co/).

### File Description

***static analysis*** stores all the files used for program analysis.

The patterns of each vulnerability are described in ***patterns.md***.

***handleJson.py*** is used for program pruning and symbolic execution.

***analysis_unit.py*** is used to analyze unit files.

***contract.py*** is the main file for contract vulnerability detection.

***baseBlock.py*** is used to store CFG basic block classes.

***graph.py*** is responsible for handling the graph and ring algorithm.

***utils.py*** and ***generator.py*** are general tool classes.

---
# Evaluation
We have publicly released a dataset comprising 897 real code snippets from *Stack Overflow*, and uploaded all experimental data to the folder ***evaluation***. The data is systematically organized in alignment with the research questions outlined in the evaluation section of our paper.

---
# Survey
To confirm the widespread use of the code from *Stack Overflow* among smart contract practitioners, we developed an online survey.

### File Description

***survey/repo keywords.txt*** stores the keywords we search for GitHub repositories, and contributors related to these repositories will receive our online survey.

Survey Links:

1. [English Version](https://forms.gle/LtrD4HnnT8Yoeo4q6)
2. [Chinese Version](https://www.wjx.cn/vm/mB5kmTG.aspx#)

If the link fails, you can browse the PDF files in our repository (***survey/EN.pdf*** or ***survey/CN.pdf***).