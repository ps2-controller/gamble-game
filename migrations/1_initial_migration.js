var Migrations = artifacts.require("./Migrations.sol");
const GambleFactory = artifacts.require("GambleFactory");


module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(GambleFactory);
};
