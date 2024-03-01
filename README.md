# SOChecker
SOChecker is an automated security analysis tool designed for fragmented smart contract code.

For more information, please refer to our paper **Beyond Q\&A: Bridging Smart Contract Security Gaps in Code Snippets from *Stack Overflow***.

---
# *Code Completioner*
*Finetuning dataset.json* is the file of dataset we use to finetune the model.

*llama-recipes* is the official script used by *LLaMA* for model finetuning and inference. For more information, please refer to [Github repo](https://github.com/facebookresearch/llama-recipes).

*finetuned model* is the file of model that we have finetuned.

## Running (Inference)
```
python llama-recipes/inference/eval_inference.py \
	--model_name "base_model_path"\
	--peft_model "peft_model_path" \
	--prompt_file "prompt_path(.json)" \
	--output_path "output_path(.json)" \
	--batch_size 1 \
	# 2>&1|tee "log_path(.log)"
```
The above instructions are stored in the file *run.sh*.

Please note that the base model file for *llama2-chat-13b* is not included in our repository. Users are required to download it independently and accurately designate the file path using the "base_model_path" parameter.

---
# *Vulnerability Detector*
*static analysis* stores all the files used for program analysis.
The patterns of each vulnerability are described in *static analysis/patterns.md*.