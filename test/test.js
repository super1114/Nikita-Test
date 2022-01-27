const { expect } = require("chai");

describe("Test Contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner, addr1] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("TestContract");
    let tokenAddress = '0xf67e6589c118F78f6E387855637806af022261E0';
    const testToken = await Token.deploy(tokenAddress);

    try {
      testToken = await testToken.connect(addr1);
      for (let i = 0; i < 20; i++) {
        await testToken.setPrice(1000 + i * 100);
      }
    } catch (error) {
      console.log("Cannot connect from other adddress , so try from owner account", error);
    }
    

    for (let i = 0; i < 20; i++) {
      await testToken.setPrice(1000 + i * 100);
    }

    let tokenPrice = await testToken.getPrice();

    let tokenAvgPrice = await testToken.getMonthAvgPrice(2);

  });
});  