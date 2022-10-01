describe("Deploy contract", function () {
  it("should deploy a contract", async function () {
    const contract = await ethers.getContractFactory("skullSyndicate");
    const skull = await contract.deploy(
      750,
      "nothing",
      "0xecefeddaa6971ceee00c6214adbbbc46b26fc29fdc85702b76dd516fadf4b47f",
      "0xecefeddaa6971ceee00c6214adbbbc46b26fc29fdc85702b76dd516fadf4b47f"
    );
    await skull.deployed();
    console.log("Lock deployed to:", skull.address);
  });
});
