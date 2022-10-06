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
    "0xb31cbecb7ace68fa3a61aea9b7c5a53e6600e22bdd48d5d86aacfa49a7054442";
  const HH_skull_hash =
    "0xe43d6b7879443295f93be98d79f2ccdcddfd32e460b5c4301866b8900d971863";
  const args = [1000, contractURI, HH_root_hash, HH_skull_hash];

  const ISSContract = await deploy("skullSyndicate", {
    from: deployer,
    args: args,
    log: true,
  });
  log("Deployed College contract to:", ISSContract.address);
};
