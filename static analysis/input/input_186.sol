function random() view public returns (uint)
    {

        uint answer = block.timestamp% 10 ;

        return answer;
    }


