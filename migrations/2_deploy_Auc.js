const Auc = artifacts.require("Auc");
const EAucFactory = artifacts.require('EAucFactory');
module.exports = function (deployer) {
  deployer.deploy(Auc);
  deployer.deploy(EAucFactory);
};
