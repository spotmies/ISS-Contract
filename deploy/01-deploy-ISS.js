module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  log("Deploying ISS Contract...");

  const root_hash =
    "0x28606dbda41dd044aa18c90930f12ed27de475820cc9ea3fae6fb518435d0980";

  const skull_hash =
    "0x97966092fb65f201397e6aa880e2296302d7df7bbb477ae44e51eafce4f1ce66";

  const HH_root_hash =
    "0xb834f50bde8ff12ee0bfb9e614c52213983a1d960a3f9111e47f126d13922353";
  const HH_skull_hash =
    "0xcd7106ee83b733c716fd9364eee9f331b728ef33f450dcefa0ff868862e0ad95";
  const args = [1000, "nothing", HH_root_hash, HH_skull_hash];

  const ISSContract = await deploy("skullSyndicate", {
    from: deployer,
    args: args,
    log: true,
  });
  log("Deployed College contract to:", ISSContract.address);
};
