constructor(string memory initialMessage) public {
        message = initialMessage;
    }

const Inbox = artifacts.require("Inbox");

module.exports = function (deployer) {
  deployer.deploy(Inbox, "myInitialMessage");
};


