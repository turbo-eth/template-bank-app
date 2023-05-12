import { HardhatRuntimeEnvironment } from "hardhat/types";

export default async function deploy(hardhat: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts, ethers } = hardhat;

  const { deploy } = deployments;
  const { admin, deployer, erc20TWAB, underlyingAsset } = await getNamedAccounts();

  const SVGLibrary = await deployments.get("SVGLibrary");
  const SVGRegistry = await deployments.get("SVGRegistry");
 
  const ERC20 = await deploy("ERC20TWAB", {
    contract: "ERC20TWAB",
    from: deployer,
    args: ['TOKEN', 'TKN'],
    skipIfAlreadyDeployed: true,
    log: true,
  });
  const PoolTogetherV0Render = await deploy("PoolTogetherV0Render", {
    contract: "PoolTogetherV0Render",
    from: deployer,
    args: [SVGLibrary.address, SVGRegistry.address],
    skipIfAlreadyDeployed: true,
    log: true,
  });

  const CardTraits = await deploy("CardTraits", {
    contract: "CardTraits",
    from: deployer,
    args: [],
    skipIfAlreadyDeployed: true,
    log: true,
    gasLimit: 6500000,
    // gasPrice: '45000000000',
  });

  const contactInformation = {
    name: "Web3 Savings Cards",
    description: "Powered by a Web3 Savings Protocol",
    image: "https://cloudflare-ipfs.com/ipfs/QmXP6TRR8UDi7vQ5gxF4AhxHoRwQuj3Ku3AuDggjZMyXGo",
    externalLink: "https://web3savings.network",
    sellerFeeBasisPoints: "0",
    feeRecipient: "0x0000000000000000000000000000000000000000",
  };

  const CardDesign = await deploy("CardDesign", {
    contract: "CardDesign",
    from: deployer,
    args: [deployer],
    skipIfAlreadyDeployed: true,
    log: true,
    // gasPrice: '45000000000',
  });

  const CardStorage = await deploy("CardStorage", {
    contract: "CardStorage",
    from: deployer,
    args: [PoolTogetherV0Render.address, CardTraits.address, contactInformation, ERC20.address, CardDesign.address, underlyingAsset ],
    skipIfAlreadyDeployed: true,
    log: true,
    // gasPrice: '45000000000',
  });

  const Card = await deploy("Card", {
    contract: "Card",
    from: deployer,
    args: ["Web3 Savings Card", "SAVE", CardStorage.address],
    skipIfAlreadyDeployed: true,
    log: true,
    // gasPrice: '45000000000',
  });
  
  
  const CardActivator = await deploy("CardActivator", {
    contract: "CardActivator",
    from: deployer,
    args: [admin, Card.address, CardDesign.address],
    skipIfAlreadyDeployed: true,
    log: true,
    // gasPrice: '45000000000',
  });

  const card = await ethers.getContractAt("Card", Card.address);
  const cardDesign = await ethers.getContractAt("CardDesign", CardDesign.address);
  const cardStorage = await ethers.getContractAt(
    "CardStorage",
    CardStorage.address
    );
    
  // const tx = await card.grantRoles(CardActivator.address, ethers.utils.parseEther('1'), {
  //   // gasPrice: '45000000000',
  // });
  // await tx.wait();
  
  // const tx2=  await cardDesign.setERC721KActivatorInstance(CardActivator.address, {
  //   // gasPrice: '45000000000',
  // });
  // await tx2.wait();
  // const tx3 = await cardDesign.transferOwnership(admin,{
  //   // gasPrice: '45000000000',
  // });
  // await tx3.wait();
  const tx4 = await cardStorage.setERC721KInstance(Card.address, {
    
  });
  await tx4.wait();
  const tx5 =await cardStorage.transferOwnership(admin, {

  });
  await tx5.wait();
}
