    function seeSlot() external view returns(uint) {
        assembly {
            let sl:= sload(age.slot)   
            mstore(0x00, sl)           
            return (0x00, 0x20)        
        }
    }


