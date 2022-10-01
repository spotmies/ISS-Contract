const { ethers } = require("hardhat");

async function main() {
  console.log("Sending ETH to contract...");
  // import ethers.js
  const ethers = require("ethers");
  // network: using the Rinkeby testnet
  let network = "goerli";
  // provider: Infura or Etherscan will be automatically chosen
  let provider = ethers.getDefaultProvider(network);
  // Sender private key:
  // correspondence address 0xb985d345c4bb8121cE2d18583b2a28e98D56d04b
  let privateKey =
    "deae161ae1e4f9bf39d4b376485065b6dcc18c815ef54757075d82101479a9af";
  // Create a wallet instance
  let wallet = new ethers.Wallet(privateKey, provider);
  // Receiver Address which receives Ether
  let receiverAddress = "0xf381a0Ee2B999C7B143BC452CDbeF3A3eC3E1374";
  // Ether amount to send

  // We get the contract to deploy
  let amountInEther = "0.01";
  // Create a transaction object
  let tx = {
    to: receiverAddress,
    // Convert currency unit from ether to wei
    value: ethers.utils.parseEther(amountInEther),
  };
  // Send a transaction
  wallet.sendTransaction(tx).then((txObj) => {
    console.log("txHash", txObj.hash);
    // A transaction result can be checked in a etherscan with a transaction hash which can be obtained here.
  });
}

main()
  .then(() => {
    process.exit(0);
    console.log("Amount sent successfully");
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
