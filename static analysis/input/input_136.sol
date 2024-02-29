                    if (x < sellSymbols.length) {
                        sellSymbols[x] = sellSymbols[sellSymbols.length - 1];
                        delete sellSymbols[myArray.length - 1];
                        sellSymbols.length--;
                    } else {
                        delete sellSymbols;
                    }

function except(string _item, mapping(string => bool) _ownedSymbols, mapping(string => bool) _targetAssets) internal returns (bool) {
    return _ownedSymbols[_item] && !_targetAssets[_item];
}


