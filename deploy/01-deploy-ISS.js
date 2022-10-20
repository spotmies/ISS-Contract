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
    "0x8e59d10daaef6c41461af58f0b3fdd918f4e8e0bdebb65592d3c7bae755244fe";
  const HH_skull_hash =
    "0xa3532a3eb07a2fd70b46208b7983fb5cd2c9f7621f597bc628cf39982f16ed1e";
  const args = [1000, contractURI, HH_root_hash, HH_skull_hash];

  const ISSContract = await deploy("skullSyndicate", {
    from: deployer,
    args: args,
    log: true,
  });
  log("Deployed iss contract to:", ISSContract.address);
};
