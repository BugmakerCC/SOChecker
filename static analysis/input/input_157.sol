            if(block.timestamp < timeStamp + 60){
                revert timeError(timeStamp, tokenIds[i]);
            }

            require(block.timestamp > timeStamp + 60,"not past due time");


