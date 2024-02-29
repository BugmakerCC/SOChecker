        for(uint8 participatorIndex = 0; participatorIndex<participators.length; participatorIndex++){
            rate = uint8(balances[participators[participatorIndex]]*100/pot);
            for(; participatorIndex<rate ; participatorsRatesIndex++){
                participatorsRates[participatorsRatesIndex] = participatorIndex;
            }
            balances[participators[participatorIndex]]=0;
        }


