function setkturia(string memory dhmos,string memory fek,string memory apof,string memory dieuth,string memory status,string memory cid) public {
    kturiapinakas memory value = kturiapinakas(
        dhmos,
        fek,
        apof,
        dieuth,
        status,
        cid,
        block.timestamp
    );
    kturiaupoPinakas.push(value);
    kturiap[block.timestamp] = value;
}


