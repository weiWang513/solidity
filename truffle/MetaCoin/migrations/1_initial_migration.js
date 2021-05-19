const Migrations = artifacts.require("Migrations");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  // deployer.deploy(Migrations, 1, 2, 3)
  // deployer.deploy(Migrations, {overWrite: false})
  // deployer.deploy(Migrations, {gas: 1212313, from: '0xasdascsasdashdbkjasbdhabdh'})
  // deployer.deploy([
  //   [Migrations, 1, 2, 3]
  // ])
  // 部署库LibA，然后将LibA链接到合约B，然后部署B.
  // deployer.deploy(LibA);
  // deployer.link(LibA, B);
  // deployer.deploy(B);

  // 链接 LibA 到多个合约
  // deployer.link(LibA, [B, C, D]);

  // var a, b;
  // deployer.then(function() {
  //   // 创建一个新版本的 A
  //   return A.new();
  // }).then(function(instance) {
  //   a = instance;
  //   // 获取部署的 B 实例
  //   return B.deployed();
  // }).then(function(instance) {
  //   b = instance;
  //   // 通过B的setA（）函数在B上设置A的新实例地址
  //   return b.setA(a.address);
  // });

};
