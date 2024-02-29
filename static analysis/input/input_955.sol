    require(
        msg.value.getconversionRate(priceFeed) >= minimumUSD,
        "Didn't send enough!"
    );

        it.only("Fails if not sending enough ETH", async function () {
            await expect(fundMe.fund()).to.be.revertedWith(
                "Didn't send enough!"
            )
        })


