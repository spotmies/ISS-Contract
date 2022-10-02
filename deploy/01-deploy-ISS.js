module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  log("Deploying ISS Contract...");

  const root_hash =
    "0x28606dbda41dd044aa18c90930f12ed27de475820cc9ea3fae6fb518435d0980";

  const skull_hash =
    "0x97966092fb65f201397e6aa880e2296302d7df7bbb477ae44e51eafce4f1ce66";

  const HH_root_hash =
    "0x1851855d606db3a0bd811d5a9175b48ecd0f6b8a7666476f5f721b9018682434";
  const HH_skull_hash =
    "0x5b2dd006ca115df682c63afaefb3a977b7d02d084628cf6b3cc879edcdf0dc93";
  const args = [1000, "nothing", HH_root_hash, HH_skull_hash];

  const ISSContract = await deploy("skullSyndicate", {
    from: deployer,
    args: args,
    log: true,
  });
  log("Deployed College contract to:", ISSContract.address);
};
