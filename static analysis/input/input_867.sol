payable(admin).transfer(balance[msg.sender]);

  function depositMoneyToAdmin() payable public {
        (bool success,) = admin.call{value: msg.value}("");
        balance[admin]+=msg.value;
         require(success,"Transfer failed!");
    }


