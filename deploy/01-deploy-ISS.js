module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  log("Deploying ISS Contract...");

  // const root_hash =
  //   "0x28606dbda41dd044aa18c90930f12ed27de475820cc9ea3fae6fb518435d0980";

  // const skull_hash =
  //   "0x97966092fb65f201397e6aa880e2296302d7df7bbb477ae44e51eafce4f1ce66";

  const contractURI =
    "https://indieskullsyndicate.mypinata.cloud/ipfs/QmSxZtEkRcBdWL9S7nEBP335Bc6TNMm6H9nmFXdq6VVUsH/";

  const HH_root_hash =
    "0x41e073ed32e8c4973f91d5526a5953368a0c504963d4d3b4637eb97f00cd5d64";
  const HH_skull_hash =
    "0x4b69e5b2406c6ff06aef158ac1167bd12db9d50245083df4688a8e279effae8a";
  const args = [1000, contractURI, HH_root_hash, HH_skull_hash];

  // const ISSContract = await deploy("skullSyndicate", {
  //   from: deployer,
  //   args: args,
  //   log: true,
  // });
  // log("Deployed iss contract to:", ISSContract.address);

  // await ISSContract.deployTransaction.wait(6);
  // await verifying(ISSContract.address, args);
  await run("verify:verify", {
    address: "0x2e6e1b66da3dd61f118a6d03c12c451f39cde0fb",
    constructorArguments: args,
  });
  console.log("ISS contract verified");
};

async function verifying(contractAddress, args) {
  console.log("Verifying contract...");
  try {
  } catch (e) {
    if (e.message.includes("Contract source code already verified")) {
      console.log("Contract source code already verified");
    } else {
      console.log(e.message);
    }
  }
}
