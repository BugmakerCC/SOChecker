IBentoBoxMinimal(bentBox).setMasterContractApproval(
               address(this), 
               _sushiswapTridentRouterAddress,
               true,
               0,
               0,
               0
           );

        IERC20Upgradeable(pool).safeIncreaseAllowance(
            bentBox,
           amountIn
        );


