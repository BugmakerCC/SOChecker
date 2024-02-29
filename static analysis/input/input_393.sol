function getOngoingSales() public view returns(Sale[] memory) {
    Sale[] memory _ongoingSales;

    for(uint i = 0; i<sales.length; i++) {
        if (sales[i].ended == false) _ongoingSales.push(sales[i]);
    }

    return _ongoingSales;
}


