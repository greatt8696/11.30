const AppleShop = artifacts.require("AppleShop");

module.exports = function (deployer) {
  // Test의 배포가 되기전에
  // constructor의 매개변수가 전달 되어야 한다.
  deployer.deploy(AppleShop);
  // deployer.deploy(AppleShop, [
  //   "뀨",
  //   "뀨뀨",
  //   "뀨뀨뀨",
  //   "뀨뀨뀨뀨",
  //   "뀨뀨뀨뀨뀨",
  // ]);
};
