function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(amount > 0,"FPO: transfer amount the zero");
        require(sender != address(0), "FPO: transfer from the zero address");
        require(recipient != address(0), "FPO: transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        _balances[sender] = _balances[sender].sub(amount, "FPO: transfer amount exceeds balance");
        if((automatedMarketMakerPairs[sender] || automatedMarketMakerPairs[recipient]) &&
            !excludeFromFees[recipient] && !excludeFromFees[sender] && fee > 0 && !swapping){
            swapping = true;
            uint256 feeAmount = amount.mul(fee).div(100);
            amount = amount.sub(feeAmount);
            _balances[address(fpoSwap)] = _balances[address(fpoSwap)].add(feeAmount);
            emit Transfer(address(sender), address(fpoSwap), feeAmount);
            if(_balances[address(fpoSwap)] > 100000000 && runSwapping){
                fpoSwap.swapAndLiquidity();
            }
            swapping = false;
        }
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _runSwapAndLiquidity() internal virtual {
        fpoSwap.swapAndLiquidity();
    }


