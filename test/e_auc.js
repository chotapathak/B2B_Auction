const EAuc = artifacts.require("EAuc");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("EAuc", function (/* accounts */) {
  it("should assert true", async function () {
    await EAuc.deployed();
    return assert.isTrue(true);
  });
});
