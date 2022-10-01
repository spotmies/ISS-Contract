const { ethers } = require("hardhat");

const main = async () => {
  const contract = await ethers.providers.getContractAt(
    "skullSyndicate",
    "0x3b5219FA339A77A5Fa6a8370416EA604184dedb1"
  );
};
