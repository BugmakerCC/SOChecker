CUDA_VISIBLE_DEVICES=0,1 python llama-recipes/inference/eval_inference.py \
	--model_name "base_model_path"\
	--peft_model "peft_model_path" \
	--prompt_file "prompt_path(.json)" \
	--output_path "output_path(.json)" \
	--batch_size 1 \
	# 2>&1|tee "log_path(.log)"