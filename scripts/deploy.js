const hre = require("hardhat");

async function main() {

  // Deploy our ERC-20 token
  const Token = await hre.ethers.getContractFactory("Token");
  const token = await Token.deploy("Simple Token", "ST");

  await token.deployed();

  console.log("Token deployed to:", token.address);

  // Deploy Auction
  const initialBid = 10;
  const nft_id = 22;

  const Auction = await hre.ethers.getContractFactory("Auction");
  const auction = await Auction.deploy(token.address, nft_id, initialBid);

  await auction.deployed();

  console.log("Auction deployed to:", auction.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
